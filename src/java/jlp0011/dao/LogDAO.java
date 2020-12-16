/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jlp0011.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import jlp0011.dto.LogDTO;
import jlp0011.util.DBUtil;

/**
 *
 * @author DELL
 */
public class LogDAO {

    private Connection con;
    private PreparedStatement stm;
    private ResultSet rs;

    public LogDAO() {
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

    public LogDTO findLastProductLog(int proId) throws SQLException, ClassNotFoundException, NamingException {
        LogDTO result = null;
        try {
            String sql = "SELECT logId, userId, date "
                    + "FROM tblLog WHERE status = 1 "
                    + "AND productId = ?";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, proId);
            rs = stm.executeQuery();
            if (rs.next()) {
                int logId = rs.getInt("logId");
                String userId = rs.getString("userId");
                Date date = rs.getDate("date");
                result = new LogDTO(logId, userId, proId, date);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public boolean updateProductLog(LogDTO log) throws SQLException, ClassNotFoundException, NamingException {
        boolean result = false;
        try {
            String sql = "UPDATE tblLog "
                    + "SET status = 0 "
                    + "WHERE logId = ?";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, log.getLogId());
            result = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return result;
    }

    public boolean addProductLog(LogDTO log) throws SQLException, ClassNotFoundException, NamingException {
        boolean result = false;
        try {
            String sql = "INSERT INTO tblLog(userId, productId, date, status) "
                    + "VALUES(?,?,?,1)";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, log.getUserId());
            stm.setInt(2, log.getProductId());
            stm.setDate(3, log.getDate());
            result = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return result;
    }

    public List<LogDTO> getAll(int currentPage, int rowPerPage) throws SQLException, ClassNotFoundException, NamingException {
        List<LogDTO> result = null;
        try {
            String sql = "SELECT logId, userId, date , productId "
                    + "FROM tblLog WHERE status = 1 "
                    + "ORDER BY logId ASC "
                    + "OFFSET ? * ? ROWS "
                    + "FETCH NEXT ? ROWS ONLY ";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, currentPage - 1);
            stm.setInt(2, rowPerPage);
            stm.setInt(3, rowPerPage);
            rs = stm.executeQuery();
            while (rs.next()) {
                if (result == null) {
                    result = new ArrayList<>();
                }
                int logId = rs.getInt("logId");
                int proId = rs.getInt("productId");
                String userId = rs.getString("userId");
                Date date = rs.getDate("date");
                LogDTO log = new LogDTO(logId, userId, proId, date);
                result.add(log);
            }
        } finally {
            closeConnection();
        }
        return result;
    }
    
    public int countLog() throws SQLException, ClassNotFoundException, NamingException {
        int result = 0;
        try {
            String sql = "SELECT COUNT(logId) as NumberOfLog "
                    + "FROM tblLog WHERE status = 1 ";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            rs = stm.executeQuery();
            if (rs.next()) {
                result = rs.getInt("NumberofLog");
            }
        } finally {
            closeConnection();
        }
        return result;
    }
}
