/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jlp0011.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import jlp0011.dao.CategoryDAO;
import jlp0011.dao.ProductDAO;
import jlp0011.dto.CategoryDTO;
import jlp0011.dto.ProductDTO;
import jlp0011.dto.UserDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author DELL
 */
public class ListAllCakeController extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(ListAllCakeController.class);
    private final String LIST_RESULT = "listCake.jsp";
    private final String ERROR = "error.jsp";
    private final int ROWS_PER_PAGE = 20;
    private final String SEARCH = "search.jsp";
    private final String LOGIN ="login.jsp";
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
            ProductDAO dao = new ProductDAO();
            CategoryDAO cateDao = new CategoryDAO();
            HttpSession session = request.getSession();
            try {
                UserDTO user = (UserDTO) session.getAttribute("user");
                if (user == null) {
                    request.setAttribute("userNotAuthenticated", "Please login first");
                    url = LOGIN;
                }
                else if (user.getRoleId() == 1) {
                    String page = request.getParameter("txtCurrentPage");
                    int currentPage = 1;
                    if (page != null) {
                        currentPage = Integer.parseInt(page);
                    }
                    int numOfCake = dao.countCakeInShop();
                    int numOfPage = (int) (Math.ceil((numOfCake * 1.0) / ROWS_PER_PAGE));
                    if (currentPage > numOfPage || currentPage <= 0) {
                        currentPage = 1;
                    }
                    List<CategoryDTO> listCate = cateDao.getAll();
                    if (session.getAttribute("listCategory") != null) {
                        session.removeAttribute("listCategory");
                    }
                    session.setAttribute("listCategory", listCate);
                    List<ProductDTO> result = dao.getAllProduct(currentPage, ROWS_PER_PAGE);
                    if (result == null) {
                        request.setAttribute("listCakeEmptyError", "List Cake is Empty");
                    } else {
                        request.setAttribute("listCakeResult", result);
                        request.setAttribute("currentPage", currentPage);
                        request.setAttribute("numberOfPage", numOfPage);
                    }
                    url = LIST_RESULT;
                }
                else{
                    request.setAttribute("noRight", "View list cake fail");
                    url = SEARCH;
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
