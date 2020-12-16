/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jlp0011.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import jlp0011.dao.LogDAO;
import jlp0011.dao.ProductDAO;
import jlp0011.dto.LogDTO;
import jlp0011.dto.ProductDTO;
import jlp0011.dto.UserDTO;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;

/**
 *
 * @author DELL
 */
public class UpdateCakeController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final Logger LOG = Logger.getLogger(UpdateCakeController.class);
    private final String ERROR = "updateCake.jsp";
    private final String SUCCESS = "ListAllCakeController";
    private final String SEARCH = "search.jsp";
    private final String LOGIN = "login.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String url = ERROR;
            ProductDAO proDao = new ProductDAO();
            LogDAO logDao = new LogDAO();
            HttpSession session = request.getSession();
            try {
                UserDTO user = (UserDTO) session.getAttribute("user");
                if (user == null) {
                    request.setAttribute("userNotAuthenticated", "Please login first");
                    url = LOGIN;
                } else if (user.getRoleId() == 1) {
                    boolean isMultiPart = ServletFileUpload.isMultipartContent(request);
                    if (isMultiPart) {
                        String imageName = null;
                        FileItemFactory factory = new DiskFileItemFactory();
                        ServletFileUpload upload = new ServletFileUpload(factory);
                        HashMap params = new HashMap();
                        List items = upload.parseRequest(request);
                        Iterator iter = items.iterator();
                        while (iter.hasNext()) {
                            FileItem item = (FileItem) iter.next();
                            if (item.isFormField()) {
                                params.put(item.getFieldName(), item.getString());
                            } else {
                                String itemName = item.getName();
                                imageName = itemName.substring(
                                        itemName.lastIndexOf("\\") + 1);
                                if (!proDao.checkImage(imageName)) {
                                    String RealPath = getServletContext().getRealPath("/")
                                            + "images\\" + imageName;
                                    File savedFile = new File(RealPath);
                                    item.write(savedFile);
                                }
                            }
                        }
                        String proId = (String) params.get("txtProductId");
                        String name = (String) params.get("txtProductName");
                        String des = (String) params.get("txtDescription");
                        String price = (String) params.get("txtPrice");
                        String quantity = (String) params.get("txtQuantity");
                        String creDate = (String) params.get("txtCreateDate");
                        String expDate = (String) params.get("txtExpirationDate");
                        String cateId = (String) params.get("cboCategory");
                        String cbStatus = (String) params.get("cbStatus");
                        boolean status = true;

                        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                        Date expirationDate = new java.sql.Date((format.parse(expDate).getTime()));
                        Date createDate = new java.sql.Date((format.parse(creDate).getTime()));
                        if (cbStatus == null) {
                            status = false;
                        }
                        int productId = Integer.parseInt(proId);
                        int numPrice = Integer.parseInt(price);
                        int numQuantity = Integer.parseInt(quantity);
                        int numCateId = Integer.parseInt(cateId);
                        ProductDTO pro = new ProductDTO(productId, name, des, numPrice, numQuantity, numCateId, createDate, expirationDate, imageName, status);
                        proDao.updateProduct(pro);
                        LogDTO latProLog = logDao.findLastProductLog(productId);
                        if (latProLog != null) {
                            logDao.updateProductLog(latProLog);
                        }
                        Date currentDate = new Date(System.currentTimeMillis());
                        LogDTO newLog = new LogDTO(user.getUserId(), productId, currentDate);
                        logDao.addProductLog(newLog);
                        url = SUCCESS;
                        request.setAttribute("updateSuccess", "Update cake Success");
                    }
                } else {
                    request.setAttribute("noRight", "Update cake fail");

                    url = SEARCH;
                }
            } catch (Exception e) {
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
