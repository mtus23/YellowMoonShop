/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jlp0011.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
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
import jlp0011.dao.ProductDAO;
import jlp0011.dto.CartDTO;
import jlp0011.dto.ProductDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author DELL
 */
public class CheckOutController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final Logger LOG = Logger.getLogger(CheckOutController.class);
    private final String CONFIRM_PAGE = "confirm.jsp";
    private final String ERROR = "cart.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String url = ERROR;
            ProductDAO proDao = new ProductDAO();
            HttpSession session = request.getSession();
            try {
                String customerName = request.getParameter("txtCustomer");
                String cusAddress = request.getParameter("txtAddress");
                String phone = request.getParameter("txtPhone");
                boolean check = true;
                List<String> error = null;
                CartDTO cart = (CartDTO) session.getAttribute("Cart");
                if (cart != null) {
                    if (cart.getTotalPrice() == 0) {
                        check = false;
                        request.setAttribute("CheckOutError", "Cart is empty");
                    }

                    Map<ProductDTO, Integer> list = cart.getItems();
                    for (ProductDTO pro : list.keySet()) {
                        if (list.get(pro) > proDao.getProduct(pro.getProductId()).getQuantity()) {
                            check = false;
                            if (error == null) {
                                error = new ArrayList<>();
                            }
                            error.add("There 're not enough cake " + pro.getName() + " in stock");
                        }
                    }
                } else {
                    request.setAttribute("CheckOutError", "Cart is empty");
                    check = false;
                }
                if (check) {
                    request.setAttribute("CustomerName", customerName);
                    request.setAttribute("CustomerAddress", cusAddress);
                    request.setAttribute("CustomerPhone", phone);
                    url = CONFIRM_PAGE;
                } else {
                    request.setAttribute("OutOfBoundCakeError", error);
                }

            } catch (SQLException | ClassNotFoundException | NamingException e) {
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
