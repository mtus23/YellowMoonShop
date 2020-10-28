/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jlp0011.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jlp0011.dao.ProductDAO;
import jlp0011.dto.ProductDTO;
import jlp0011.util.ValidImage;
import org.apache.log4j.Logger;

/**
 *
 * @author DELL
 */
public class CreateCakeController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private final static Logger LOG = Logger.getLogger(CreateCakeController.class);
    private final String SUCCESS = "ListAllCakeController";
    private final String ERROR = "createCake.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String url = ERROR;
            boolean check = true;
            ProductDAO proDao = new ProductDAO();
            try {
                String name = request.getParameter("txtProductName");
                String imageLink = request.getParameter("txtImage");
                String des = request.getParameter("txtDescription");
                String price = request.getParameter("txtPrice");
                String quantity = request.getParameter("txtQuantity");
                String creDate = request.getParameter("txtCreateDate");
                String expDate = request.getParameter("txtExpirationDate");
                String cateId = request.getParameter("cboCategory");

                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                Date createDate = new java.sql.Date((format.parse(creDate).getTime()));
                Date expirationDate = new java.sql.Date((format.parse(expDate).getTime()));
                if (!(expirationDate.compareTo(createDate) > 0)) {
                    request.setAttribute("ErrorDate", "Expiration date must be after create date");
                    check = false;
                }
                boolean imagecheck = ValidImage.isImageExist(imageLink);
                if (!imagecheck) {
                    request.setAttribute("ErrorImage", "Cant find image");
                    check = false;
                }
                if (check) {
                    int numPrice = Integer.parseInt(price);
                    int numQuantity = Integer.parseInt(quantity);
                    int numCateId = Integer.parseInt(cateId);
                    ProductDTO pro = new ProductDTO(name, des, numPrice, numQuantity, numCateId, createDate, expirationDate, imageLink);
                    proDao.addProduct(pro);
                    url = SUCCESS;
                }
                LOG.info(check);
            } catch (ParseException | SQLException | NamingException | ClassNotFoundException e) {
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
