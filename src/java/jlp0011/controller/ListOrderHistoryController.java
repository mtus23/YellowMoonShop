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
public class ListOrderHistoryController extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(ListOrderHistoryController.class);
    private final String RESULT = "searchOrder.jsp";
    private final String ERROR = "error.jsp";
    private final String SEARCH = "search.jsp";
    private final String LOGIN = "login.jsp";
    private final int ROWS_PER_PAGE = 20;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String url = ERROR;
            OrderDAO orderDao = new OrderDAO();
            OrderDetailDAO orderDetailDao = new OrderDetailDAO();
            ProductDAO productDao = new ProductDAO();
            HttpSession session = request.getSession();
            try {
                UserDTO user = (UserDTO) session.getAttribute("user");
                if (user == null) {
                    request.setAttribute("userNotAuthenticated", "Please login first");
                    url = LOGIN;
                } else if (user.getRoleId() == 2) {
                    String page = request.getParameter("txtCurrentPage");
                    int currentPage = 1;
                    if (page != null) {
                        currentPage = Integer.parseInt(page);
                    }
                    int numOfOrder = orderDao.countUserOrder(user.getUserId());
                    int numOfPage = (int) (Math.ceil((numOfOrder * 1.0) / ROWS_PER_PAGE));
                    if (currentPage > numOfPage || currentPage <= 0) {
                        currentPage = 1;
                    }
                    List<OrderDTO> listOrder = orderDao.getUserOrder(user.getUserId(), currentPage, ROWS_PER_PAGE);
                    if (listOrder != null) {
                        Map<String, List<OrderDetailDTO>> mapOrderDetail = new HashMap<>();
                        Map<Integer, String> proNameList = new HashMap<>();
                        for (OrderDTO order : listOrder) {
                            List<OrderDetailDTO> proList = orderDetailDao.searchOrder(order.getOrderId());
                            if (proList != null) {
                                for (OrderDetailDTO od : proList) {
                                    ProductDTO pro = productDao.getProduct(od.getProductId());
                                    if (!proNameList.containsKey(pro.getProductId())) {
                                        proNameList.put(pro.getProductId(), pro.getName());
                                    }
                                }
                            }
                            mapOrderDetail.put(order.getOrderId(), proList);
                        }
                        request.setAttribute("listOrderHistory", listOrder);
                        request.setAttribute("mapOrderDetail", mapOrderDetail);
                        request.setAttribute("mapProductName", proNameList);
                        request.setAttribute("currentPage", currentPage);
                        request.setAttribute("numberOfPage", numOfPage);
                    } else {
                        request.setAttribute("listOrderError", "Your order history is empty");
                    }
                    url = RESULT;
                } else {
                    request.setAttribute("ViewHistoryFail", "View history fail");
                    url = SEARCH;
                }
            } catch (ClassNotFoundException | NumberFormatException | SQLException | NamingException e) {
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
