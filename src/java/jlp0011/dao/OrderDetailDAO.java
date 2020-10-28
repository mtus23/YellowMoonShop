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
import java.util.UUID;
import javax.naming.NamingException;
import jlp0011.dto.OrderDetailDTO;
import jlp0011.util.DBUtil;

/**
 *
 * @author DELL
 */
public class OrderDetailDAO implements Serializable{
    

    private Connection con;
    private PreparedStatement stm;
    private ResultSet rs;

    public OrderDetailDAO() {
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

    public boolean addOrderDetail(OrderDetailDTO dto) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        try {
            String sql = "INSERT INTO tblOrderDetail (orderId, productId, price, quantity) "
                    + "VALUES (?,?,?,?)";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, dto.getOrderId());
            stm.setInt(2, dto.getProductId());
            stm.setInt(3, dto.getPrice());
            stm.setInt(4, dto.getQuantity());
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
    
    public List<OrderDetailDTO> searchOrder(String orderId) throws SQLException, ClassNotFoundException, NamingException {
        List<OrderDetailDTO> result = null;
        try {
            String sql = "SELECT productId, price, quantity "
                    + "FROM tblOrderDetail "
                    + "WHERE orderId = ? ";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setObject(1,UUID.fromString(orderId));
            rs = stm.executeQuery();
            while (rs.next()) {
                if(result==null){
                    result=new ArrayList<>();
                }
                int productId = rs.getInt("productId");
                int price = rs.getInt("price");
                int quantity = rs.getInt("quantity");
                OrderDetailDTO dto = new OrderDetailDTO(productId, price, quantity);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }
}
