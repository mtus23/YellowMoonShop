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
import jlp0011.dao.ProductDAO;
import jlp0011.dto.ProductDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author DELL
 */
public class SearchCakeController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final Logger LOG = Logger.getLogger(SearchCakeController.class);
    private final String SEARCH_RESULT = "search.jsp";
    private final int ROWS_PER_PAGE = 20;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String url = SEARCH_RESULT;
            ProductDAO proDao = new ProductDAO();
            try {
                String name = request.getParameter("txtProductNameSearch");
                String cate = request.getParameter("cboCategory");
                String rgPrice = request.getParameter("rgPrice");
                int rangePrice = Integer.parseInt(rgPrice);
                String page = request.getParameter("txtCurrentPage");
                int currentPage = 1;
                int numOfProduct = 0;
                List<ProductDTO> result = null;
                if (page != null) {
                    currentPage = Integer.parseInt(page);
                }
                int cateId = Integer.parseInt(cate);
                if (cateId == 0) {
                    result = proDao.searchProduct(name, rangePrice, currentPage, ROWS_PER_PAGE);
                    numOfProduct = proDao.countSearchProduct(name, rangePrice);
                } else {
                    result = proDao.searchProduct(name, rangePrice, cateId, currentPage, ROWS_PER_PAGE);
                    numOfProduct = proDao.countSearchProduct(name, rangePrice, cateId);
                }
                int numOfPage = (int) (Math.ceil((numOfProduct * 1.0) / ROWS_PER_PAGE));
                if (currentPage > numOfPage || currentPage <= 0) {
                    currentPage = 1;
                }
                if (result == null) {
                    request.setAttribute("errorSearch", "Cake not found");
                } else {
                    request.setAttribute("numberOfPage", numOfPage);
                    request.setAttribute("currentPage", currentPage);
                    request.setAttribute("searchResult", result);
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
