/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jlp0011.dao;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import jlp0011.dto.ProductDTO;
import jlp0011.util.DBUtil;

/**
 *
 * @author DELL
 */
public class ProductDAO implements Serializable{

    private Connection con;
    private PreparedStatement stm;
    private ResultSet rs;

    public ProductDAO() {
    }

    private void closeConnection() throws SQLException {
        if (rs != null) {
            rs.close();
        }
        if (stm != null) {
            stm.close();
        }
        if (con != null) {
            con.close();
        }
    }

    public List<ProductDTO> getAllProduct(int currentPage, int rowPerPage) throws SQLException, ClassNotFoundException, NamingException {
        List<ProductDTO> result = null;
        try {
            String sql = "SELECT productId, name, price, description, quantity, createDate, expirationDate, image, status, categoryId  "
                    + "FROM tblProduct "
                    + "ORDER BY productId ASC "
                    + "OFFSET ( ? - 1 ) * ? ROWS "
                    + "FETCH NEXT ? ROWS ONLY ";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, currentPage);
            stm.setInt(2, rowPerPage);
            stm.setInt(3, rowPerPage);
            rs = stm.executeQuery();
            while (rs.next()) {
                int proId = rs.getInt("productId");
                String name = rs.getString("name");
                int price = rs.getInt("price");
                String des = rs.getString("description");
                int quantity = rs.getInt("quantity");
                Date creDate = rs.getDate("createDate");
                Date expDate = rs.getDate("expirationDate");
                String image = rs.getString("image");
                boolean status = rs.getBoolean("status");
                int cateId = rs.getInt("categoryId");
                ProductDTO dto = new ProductDTO(proId, name, des, price, quantity, cateId, creDate, expDate, image, status);
                if (result == null) {
                    result = new ArrayList<>();
                }
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public int countCakeInShop() throws SQLException, ClassNotFoundException, NamingException {
        int result = 0;
        try {
            String sql = "SELECT COUNT(productId) as NumberOfCake "
                    + "FROM tblProduct ";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            rs = stm.executeQuery();
            if (rs.next()) {
                result = rs.getInt("NumberofCake");
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public boolean addProduct(ProductDTO dto) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        try {
            String sql = "INSERT INTO tblProduct(name, price, quantity, categoryId, createDate, expirationDate, image, description, status) "
                    + "VALUES (?,?,?,?,?,?,?,?,1)";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, dto.getName());
            stm.setInt(2, dto.getPrice());
            stm.setInt(3, dto.getQuantity());
            stm.setInt(4, dto.getCategoryId());
            stm.setDate(5, dto.getCreateDate());
            stm.setDate(6, dto.getExpirationDate());
            stm.setString(7, dto.getImage());
            stm.setString(8, dto.getDescription());
            check = stm.executeUpdate() > 0;

        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean updateProduct(ProductDTO dto) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        try {
            String sql = "UPDATE tblProduct "
                    + "SET name  = ?, "
                    + "image = ?, "
                    + "description = ?, "
                    + "price = ?, "
                    + "quantity = ?, "
                    + "createDate = ?, "
                    + "expirationDate = ?, "
                    + "categoryId =?, "
                    +"status = ? "
                    + "WHERE productId = ?";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, dto.getName());
            stm.setString(2, dto.getImage());
            stm.setString(3, dto.getDescription());
            stm.setInt(4, dto.getPrice());
            stm.setInt(5, dto.getQuantity());
            stm.setDate(6, dto.getCreateDate());
            stm.setDate(7, dto.getExpirationDate());
            stm.setInt(8, dto.getCategoryId());
            stm.setBoolean(9, dto.isStatus());
            stm.setInt(10, dto.getProductId());
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
    
    public List<ProductDTO> searchProduct(String name, int rangePrice, int currentPage, int rowPerPage) throws SQLException, ClassNotFoundException, NamingException {
        List<ProductDTO> result = null;
        try {
            String sql = "SELECT productId, name, price, description, quantity, createDate, expirationDate, image, status, categoryId  "
                    + "FROM tblProduct "
                    + "WHERE name LIKE ? AND price < ? AND status = 1 AND quantity > 0 "
                    + "ORDER BY productId ASC "
                    + "OFFSET ( ? - 1 ) * ? ROWS "
                    + "FETCH NEXT ? ROWS ONLY ";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, "%"+name+"%");
            stm.setInt(2, rangePrice);
            stm.setInt(3, currentPage);
            stm.setInt(4, rowPerPage);
            stm.setInt(5, rowPerPage);
            rs = stm.executeQuery();
            while (rs.next()) {
                String proName = rs.getString("name");
                int proId = rs.getInt("productId");
                int price = rs.getInt("price");
                String des = rs.getString("description");
                int quantity = rs.getInt("quantity");
                Date creDate = rs.getDate("createDate");
                Date expDate = rs.getDate("expirationDate");
                String image = rs.getString("image");
                boolean status = rs.getBoolean("status");
                int cateId = rs.getInt("categoryId");
                ProductDTO dto = new ProductDTO(proId, proName, des, price, quantity, cateId, creDate, expDate, image, status);
                if (result == null) {
                    result = new ArrayList<>();
                }
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }
    
    public List<ProductDTO> searchProduct(String name, int rangePrice, int cateId, int currentPage, int rowPerPage) throws SQLException, ClassNotFoundException, NamingException {
        List<ProductDTO> result = null;
        try {
            String sql = "SELECT productId, name, price, description, quantity, createDate, expirationDate, image, status, categoryId  "
                    + "FROM tblProduct "
                    + "WHERE name LIKE ? AND price < ? AND categoryId = ? AND status = 1 AND quantity > 0 "
                    + "ORDER BY productId ASC "
                    + "OFFSET ( ? - 1 ) * ? ROWS "
                    + "FETCH NEXT ? ROWS ONLY ";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, "%"+name+"%");
            stm.setInt(2, rangePrice);
            stm.setInt(3, cateId);
            stm.setInt(4, currentPage);
            stm.setInt(5, rowPerPage);
            stm.setInt(6, rowPerPage);
            rs = stm.executeQuery();
            while (rs.next()) {
                String proName = rs.getString("name");
                int proId = rs.getInt("productId");
                int price = rs.getInt("price");
                String des = rs.getString("description");
                int quantity = rs.getInt("quantity");
                Date creDate = rs.getDate("createDate");
                Date expDate = rs.getDate("expirationDate");
                String image = rs.getString("image");
                boolean status = rs.getBoolean("status");
                ProductDTO dto = new ProductDTO(proId, proName, des, price, quantity, cateId, creDate, expDate, image, status);
                if (result == null) {
                    result = new ArrayList<>();
                }
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }
    
    public int CountSearchProduct(String name, int rangePrice, int cateId) throws SQLException, ClassNotFoundException, NamingException {
        int result = 0;
        try {
            String sql = "SELECT COUNT(productId) AS NumberOdProduct "
                    + "FROM tblProduct "
                    + "WHERE name LIKE ? AND price < ? AND categoryId = ? AND status = 1";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, "%"+name+"%");
            stm.setInt(2, rangePrice);
            stm.setInt(3, cateId);
            rs = stm.executeQuery();
            if (rs.next()) {
                result = rs.getInt("NumberOdProduct");
            }
        } finally {
            closeConnection();
        }
        return result;
    }
    
    public int CountSearchProduct(String name, int rangePrice) throws SQLException, ClassNotFoundException, NamingException {
        int result = 0;
        try {
            String sql = "SELECT COUNT(productId) AS NumberOdProduct "
                    + "FROM tblProduct "
                    + "WHERE name LIKE ? AND price < ?  AND status = 1";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, "%"+name+"%");
            stm.setInt(2, rangePrice);
            rs = stm.executeQuery();
            if (rs.next()) {
                result = rs.getInt("NumberOdProduct");
            }
        } finally {
            closeConnection();
        }
        return result;
    }
    
        public ProductDTO getProduct(int productId) throws SQLException, ClassNotFoundException, NamingException {
        ProductDTO result = null;
        try {
            String sql = "SELECT name, price, description, quantity, createDate, expirationDate, image, status, categoryId  "
                    + "FROM tblProduct "
                    + "WHERE productId = ?";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, productId);
            rs = stm.executeQuery();
            if (rs.next()) {
                String name = rs.getString("name");
                int price = rs.getInt("price");
                String des = rs.getString("description");
                int quantity = rs.getInt("quantity");
                Date creDate = rs.getDate("createDate");
                Date expDate = rs.getDate("expirationDate");
                String image = rs.getString("image");
                boolean status = rs.getBoolean("status");
                int cateId = rs.getInt("categoryId");
                result = new ProductDTO(productId, name, des, price, quantity, cateId, creDate, expDate, image, status);
            }
        } finally {
            closeConnection();
        }
        return result;
    }
}
