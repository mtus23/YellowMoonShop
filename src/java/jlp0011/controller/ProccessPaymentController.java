/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jlp0011.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import jlp0011.dao.OrderDAO;
import jlp0011.dao.OrderDetailDAO;
import jlp0011.dao.ProductDAO;
import jlp0011.dto.CartDTO;
import jlp0011.dto.OrderDTO;
import jlp0011.dto.OrderDetailDTO;
import jlp0011.dto.ProductDTO;
import jlp0011.dto.UserDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author DELL
 */
public class ProccessPaymentController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final Logger LOG = Logger.getLogger(ProccessPaymentController.class);
    private final String CONFIRM_PAGE = "confirm.jsp";
    private final String ERROR = "cart.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String url = ERROR;
            String customerName = request.getParameter("txtCustomerName");
            String customerAddress = request.getParameter("txtCustomerAddress");
            String customerPhone = request.getParameter("txtCustomerPhone");

            try {
                HttpSession session = request.getSession();
                UserDTO user = (UserDTO) session.getAttribute("User");
                Timestamp currentTime = new Timestamp(System.currentTimeMillis());
                OrderDTO order = null;
                List<String> error = null;

                boolean lastCheck = true;
                OrderDAO orderDao = new OrderDAO();
                OrderDetailDAO orderDetailDao = new OrderDetailDAO();
                ProductDAO proDao = new ProductDAO();

                CartDTO cart = (CartDTO) session.getAttribute("Cart");
                if (cart != null) {
                    Map<ProductDTO, Integer> list = cart.getItems();
                    if (list != null) {
                        for (ProductDTO pro : list.keySet()) {
                            if (list.get(pro) > proDao.getProduct(pro.getProductId()).getQuantity()) {
                                lastCheck = false;
                                if (error == null) {
                                    error = new ArrayList<>();
                                }
                                error.add("There 're not enough cake " + pro.getName() + " in stock");
                            }
                        }
                        if (lastCheck) {
                            int total = cart.getTotalPrice();
                            if (user != null) {
                                order = new OrderDTO(user.getUserId(), total, customerPhone, customerAddress, currentTime, customerName);
                            } else {
                                order = new OrderDTO(total, customerPhone, customerAddress, currentTime, customerName);
                            }
                            boolean check = orderDao.addOrder(order);
                            if (check) {
                                String orderId = orderDao.getLastOrderId();
                                for (ProductDTO pro : list.keySet()) {
                                    int proId = pro.getProductId();
                                    int quantity = list.get(pro);
                                    OrderDetailDTO orderDetailDto = new OrderDetailDTO(orderId, proId, pro.getPrice(), quantity);
                                    orderDetailDao.addOrderDetail(orderDetailDto);

                                    ProductDTO product = proDao.getProduct(proId);
                                    int currQuantity = product.getQuantity();
                                    product.setQuantity(currQuantity - quantity);
                                    proDao.updateProduct(product);
                                }
                                cart.clearCart();
                                session.removeAttribute("Cart");
                                session.removeAttribute("TotalBill");
                                request.setAttribute("AddSuccess", "Checkout successfully");
                                request.setAttribute("OrderId", orderId);
                                url = CONFIRM_PAGE;
                            }
                        } else {
                            request.setAttribute("OutOfBoundCakeError", error);
                        }
                    }
                }
            } catch (SQLException | ClassNotFoundException | NamingException e) {
                LOG.error(e.toString());
            } finally {
                RequestDispatcher rd = request.getRequestDispatcher(url);
                rd.forward(request, response);
//            response.sendRedirect(url);
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
