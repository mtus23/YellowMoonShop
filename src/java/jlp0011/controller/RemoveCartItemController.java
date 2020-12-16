/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jlp0011.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import jlp0011.dto.CartDTO;
import jlp0011.dto.UserDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author DELL
 */
public class RemoveCartItemController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private final String CART_PAGE = "cart.jsp";
    private final String ERROR = "error.jsp";
    private final String SEARCH = "search.jsp";
    private static final Logger LOG = Logger.getLogger(RemoveCartItemController.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String url = ERROR;
            try {
                HttpSession session = request.getSession();
                UserDTO user = (UserDTO) session.getAttribute("user");
                if (!(user != null && user.getRoleId() == 1)) {
                    CartDTO cart = (CartDTO) session.getAttribute("cart");
                    if (cart.getItems() != null) {
                        String[] items = request.getParameterValues("cbItem");
                        int total = 0;
                        if (items != null) {
                            for (String item : items) {
                                int proId = Integer.parseInt(item);
                                cart.removeProductFromCart(proId);
                            }
                            total = cart.getTotalPrice();
                            session.setAttribute("totalBill", total);
                            session.setAttribute("cart", cart);
                            request.setAttribute("removeCartSuccess", "Remove Cake from cart success");
                        }
                    }
                    url = CART_PAGE;
                } else {
                    url = SEARCH;
                    request.setAttribute("RemoveFail", "Remove cake form cart fail");
                }
            } catch (NumberFormatException e) {
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
