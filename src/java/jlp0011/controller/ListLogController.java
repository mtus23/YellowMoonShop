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
import jlp0011.dao.LogDAO;
import jlp0011.dao.ProductDAO;
import jlp0011.dao.UserDAO;
import jlp0011.dto.LogDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author DELL
 */
public class ListLogController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final Logger LOG = Logger.getLogger(ListLogController.class);
    private final String LIST_RESULT = "viewLog.jsp";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String url = LIST_RESULT;
            LogDAO logDao = new LogDAO();
            ProductDAO proDao = new ProductDAO();
            UserDAO userDao = new UserDAO();
            try {
                List<LogDTO> listLog = logDao.getAll();
                if (listLog == null) {
                    request.setAttribute("ListAllLogError", "List log is empty");
                } else {
                    Map<Integer, String> mapProName = new HashMap<>();
                    Map<String, String> mapUserName = new HashMap<>();
                    for(LogDTO log : listLog){
                        String userName = userDao.getUserName(log.getUserId());
                        mapUserName.put(log.getUserId(), userName);
                        String proName = proDao.getProduct(log.getProductId()).getName();
                        mapProName.put(log.getProductId(), proName);
                    }
                    request.setAttribute("MapProductName", mapProName);
                    request.setAttribute("MapUserName", mapUserName);
                    request.setAttribute("ListLog", listLog);
                }
                url = LIST_RESULT;
            } catch (NamingException | SQLException | ClassNotFoundException e) {
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
