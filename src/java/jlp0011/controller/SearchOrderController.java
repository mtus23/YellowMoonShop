/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jlp0011.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashMap;
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
import jlp0011.dto.OrderDTO;
import jlp0011.dto.OrderDetailDTO;
import jlp0011.dto.ProductDTO;
import jlp0011.dto.UserDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author DELL
 */
public class SearchOrderController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final Logger LOG = Logger.getLogger(SearchOrderController.class);
    private final String SEARCH_RESULT = "searchOrder.jsp";
    private final String ERROR = "error.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String url = ERROR;
            String search = request.getParameter("txtOrderId");
            OrderDAO orderDao = new OrderDAO();
            OrderDetailDAO orderDetailDao = new OrderDetailDAO();
            ProductDAO productDao = new ProductDAO();
            HttpSession session = request.getSession();
            try {
                UserDTO user = (UserDTO) session.getAttribute("User");
                if (user != null) {
                    OrderDTO orderDto = orderDao.searchOrder(search, user.getUserId());
                    if (orderDto != null) {
                        List<OrderDetailDTO> proList = orderDetailDao.searchOrder(orderDto.getOrderId());
                        if (proList != null) {
                            Map<Integer, String> proNameList = new HashMap<>();
                            for (OrderDetailDTO od : proList) {
                                ProductDTO pro = productDao.getProduct(od.getProductId());
                                proNameList.put(pro.getProductId(), pro.getName());
                            }
                            request.setAttribute("OrderFound", orderDto);
                            request.setAttribute("ListOrderDetail", proList);
                            request.setAttribute("MapProductName", proNameList);
                        }
                    } else {
                        request.setAttribute("OrderSearchError", "Order not found");

                    }
                    url = SEARCH_RESULT;
                }
            } catch (SQLException | NamingException | ClassNotFoundException e) {
                LOG.error(e.toString());
            } finally {
                RequestDispatcher rd = request.getRequestDispatcher(url);
                rd.forward(request, response);
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
