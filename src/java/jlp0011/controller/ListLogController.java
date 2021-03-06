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
import jlp0011.dao.LogDAO;
import jlp0011.dao.ProductDAO;
import jlp0011.dao.UserDAO;
import jlp0011.dto.LogDTO;
import jlp0011.dto.UserDTO;
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
    private final String SEARCH = "search.jsp";
    private final int ROWS_PER_PAGE = 20;
    private final String LOGIN = "login.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String url = LIST_RESULT;
            LogDAO logDao = new LogDAO();
            ProductDAO proDao = new ProductDAO();
            UserDAO userDao = new UserDAO();
            HttpSession session = request.getSession();
            try {
                UserDTO user = (UserDTO) session.getAttribute("user");
                if (user == null) {
                    request.setAttribute("userNotAuthenticated", "Please login first");
                    url = LOGIN;
                } else if (user.getRoleId() == 1) {
                    String page = request.getParameter("txtCurrentPage");
                    int currentPage = 1;
                    if (page != null) {
                        currentPage = Integer.parseInt(page);
                    }
                    int numOfLog = logDao.countLog();
                    int numOfPage = (int) (Math.ceil((numOfLog * 1.0) / ROWS_PER_PAGE));
                    if (currentPage > numOfPage || currentPage <= 0) {
                        currentPage = 1;
                    }
                    List<LogDTO> listLog = logDao.getAll(currentPage, ROWS_PER_PAGE);
                    if (listLog == null) {
                        request.setAttribute("listAllLogError", "List log is empty");
                    } else {
                        Map<Integer, String> mapProName = new HashMap<>();
                        Map<String, String> mapUserName = new HashMap<>();
                        for (LogDTO log : listLog) {
                            String userName = userDao.getUserName(log.getUserId());
                            mapUserName.put(log.getUserId(), userName);
                            String proName = proDao.getProduct(log.getProductId()).getName();
                            mapProName.put(log.getProductId(), proName);
                        }
                        request.setAttribute("mapProductName", mapProName);
                        request.setAttribute("mapUserName", mapUserName);
                        request.setAttribute("listLog", listLog);
                        request.setAttribute("currentPage", currentPage);
                        request.setAttribute("numberOfPage", numOfPage);
                    }
                    url = LIST_RESULT;
                } else {
                    request.setAttribute("noRight", "View log fail");

                    url = SEARCH;
                }
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
