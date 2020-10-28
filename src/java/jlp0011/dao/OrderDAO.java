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
import java.sql.Timestamp;
import java.util.UUID;
import javax.naming.NamingException;
import jlp0011.dto.OrderDTO;
import jlp0011.util.DBUtil;

/**
 *
 * @author DELL
 */
public class OrderDAO implements Serializable {

    public OrderDAO() {
    }

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

    public boolean addOrder(OrderDTO dto) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        try {
            String sql = "INSERT INTO tblOrder (userId, total, date, phone, address, name, payment, paymentStatus) "
                    + "VALUES (?,?,?,?,?,?,'cash',0)";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, dto.getUserId());
            stm.setInt(2, dto.getTotal());
            stm.setTimestamp(3, dto.getDate());
            stm.setString(4, dto.getPhone());
            stm.setString(5, dto.getAddress());
            stm.setString(6, dto.getName());
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public String getLastOrderId() throws SQLException, ClassNotFoundException, NamingException {
        String result = "";
        try {
            String sql = "SELECT TOP 1 orderId "
                    + "FROM tblOrder "
                    + "ORDER BY date DESC";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            rs = stm.executeQuery();
            if (rs.next()) {
                result = rs.getString("orderId");
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public OrderDTO searchOrder(String orderId, String userId) throws SQLException, ClassNotFoundException, NamingException {
        OrderDTO result = null;
        try {
            String sql = "SELECT total, date, phone, address, payment, name, paymentStatus "
                    + "FROM tblOrder "
                    + "WHERE orderId = ? AND userId = ?";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setObject(1, UUID.fromString(orderId));
            stm.setString(2, userId);
            rs = stm.executeQuery();
            if (rs.next()) {
                int total = rs.getInt("total");
                Timestamp date = rs.getTimestamp("date");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                String payment = rs.getString("payment");
                String name = rs.getString("name");
                boolean paymentstatus = rs.getBoolean("paymentStatus");
                result = new OrderDTO(orderId, userId, total, phone, address, date, payment, name, paymentstatus);
            }
        } finally {
            closeConnection();
        }
        return result;
    }
}
