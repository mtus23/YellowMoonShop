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
import javax.naming.NamingException;
import jlp0011.dto.UserDTO;
import jlp0011.util.DBUtil;
import jlp0011.util.DataTypeConverter;
import jlp0011.util.PasswordEncrypter;

/**
 *
 * @author DELL
 */
public class UserDAO implements Serializable{

    private Connection con;
    private PreparedStatement stm;
    private ResultSet rs;
    PasswordEncrypter pe = new PasswordEncrypter();
    private final int USER_ROLE = 2;

    public UserDAO() {
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

    public UserDTO checkLogin(String userId, String password) throws SQLException, ClassNotFoundException, NamingException {
        UserDTO dto = null;
        try {
            String sql = "SELECT name, phone, address, roleId FROM tblUser WHERE userId = ? AND password = ? AND status = 1";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, userId);
            stm.setString(2, pe.getEncryptedPassword(password));
            rs = stm.executeQuery();
            if (rs.next()) {
                String name = rs.getString("name");
                String phone = rs.getString("phone");
                int roleId = rs.getInt("roleId");
                String address = rs.getString("address");
                dto = new UserDTO(userId, name, phone, address, roleId);
            }
        } finally {
            closeConnection();
        }
        return dto;
    }

    public UserDTO checkFBLogin(String facebookId) throws SQLException, ClassNotFoundException, NamingException {
        UserDTO result = null;
        try {
            String sql = "SELECT userId, name, roleId, link FROM tblUser WHERE facebookId = ?";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, facebookId);
            rs = stm.executeQuery();
            if (rs.next()) {
                String userId = rs.getString("userId");
                String name = rs.getNString("name");
                int role = rs.getInt("roleId");
                String fbLink = rs.getString("link");
                result = new UserDTO(userId, name, role, facebookId, fbLink);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public boolean register(UserDTO dto) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        try {
            String sql = "INSERT INTO tblUser(userId, name, roleId, facebookId, link, status) VALUES (?,?,?,?,?,?)";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, dto.getUserId());
            stm.setString(2, DataTypeConverter.convertVietnamese(dto.getName()));
            stm.setInt(3, USER_ROLE);
            stm.setString(4, dto.getFacebookId());
            stm.setString(5, dto.getLink());
            stm.setBoolean(6, true);
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
    
    public String getUserName(String userId) throws SQLException, ClassNotFoundException, NamingException {
        String result = "";
        try {
            String sql = "SELECT name FROM tblUSER WHERE userId = ?";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, userId);
            rs = stm.executeQuery();
            if(rs.next()){
                result=rs.getString("name");
            }
        } finally {
            closeConnection();
        }
        return result;
    }

}
