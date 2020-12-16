/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jlp0011.dao;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import jlp0011.dto.CategoryDTO;
import jlp0011.util.DBUtil;

/**
 *
 * @author DELL
 */
public class CategoryDAO implements Serializable {

    private Connection con;
    private PreparedStatement stm;
    private ResultSet rs;

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

    public List<CategoryDTO> getAll() throws SQLException, ClassNotFoundException, NamingException {
        List<CategoryDTO> result = null;
        try {
            String sql = "SELECT categoryId, name FROM tblCategory ";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                int categoryId = rs.getInt("categoryId");
                String name = rs.getString("name");
                CategoryDTO cate = new CategoryDTO(categoryId, name);
                if (result == null) {
                    result = new ArrayList<>();
                }
                result.add(cate);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public List<CategoryDTO> getAll(int currentPage, int rowPerPage) throws SQLException, ClassNotFoundException, NamingException {
        List<CategoryDTO> result = null;
        try {
            String sql = "SELECT categoryId, name FROM tblCategory "
                    + "ORDER BY categoryId ASC "
                    + "OFFSET ? * ? ROWS "
                    + "FETCH NEXT ? ROWS ONLY ";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, currentPage - 1);
            stm.setInt(2, rowPerPage);
            stm.setInt(3, rowPerPage);
            rs = stm.executeQuery();
            while (rs.next()) {
                int categoryId = rs.getInt("categoryId");
                String name = rs.getString("name");
                CategoryDTO cate = new CategoryDTO(categoryId, name);
                if (result == null) {
                    result = new ArrayList<>();
                }
                result.add(cate);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public boolean checkDuplicatedName(String name) throws SQLException, ClassNotFoundException, NamingException {
        boolean result = false;
        try {
            String sql = "SELECT categoryId FROM tblCategory WHERE name =?";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, name);
            rs = stm.executeQuery();
            if (rs.next()) {
                result = true;
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public boolean addCategory(CategoryDTO cate) throws SQLException, ClassNotFoundException, NamingException {
        boolean result = false;
        try {
            String sql = "INSERT INTO tblCategory(name) VALUES(?)";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, cate.getName());
            result = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return result;
    }

    public boolean updateCategory(CategoryDTO cate) throws SQLException, ClassNotFoundException, NamingException {
        boolean result = false;
        try {
            String sql = "UPDATE tblCategory SET name = ? WHERE categoryId = ?";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, cate.getName());
            stm.setInt(2, cate.getCategoryId());
            result = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return result;
    }

    public int countCategory() throws SQLException, ClassNotFoundException, NamingException {
        int result = 0;
        try {
            String sql = "SELECT COUNT(categoryId) as NumberOfCate "
                    + "FROM tblCategory ";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            rs = stm.executeQuery();
            if (rs.next()) {
                result = rs.getInt("NumberofCate");
            }
        } finally {
            closeConnection();
        }
        return result;
    }
}
