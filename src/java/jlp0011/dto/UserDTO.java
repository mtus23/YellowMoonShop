/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jlp0011.dto;

import com.google.gson.annotations.SerializedName;
import java.io.Serializable;

/**
 *
 * @author DELL
 */
public class UserDTO implements Serializable{
    private String userId;
    @SerializedName(value = "name")
    private String name;
    private String phone;
    private String address;
    private String password;
    private int roleId;
    @SerializedName(value ="id")
    private String facebookId;
    private String link;

    public UserDTO() {
    }

    public UserDTO(String userId, String name, String phone, String address, int roleId) {
        this.userId = userId;
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.roleId = roleId;
    }

    public UserDTO(String userId, String name, String phone, String address, String password, int roleId, String facebookId, String link) {
        this.userId = userId;
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.password = password;
        this.roleId = roleId;
        this.facebookId = facebookId;
        this.link = link;
    }

    
    public UserDTO(String userId, String name, String phone, String address, String password, int roleId) {
        this.userId = userId;
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.password = password;
        this.roleId = roleId;
    }

    public UserDTO(String userId, String name, String phone, String address, String password) {
        this.userId = userId;
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.password = password;
    }

    public UserDTO(String name, int roleId, String facebookId, String facebookLink) {
        this.name = name;
        this.roleId = roleId;
        this.facebookId = facebookId;
        this.link = facebookLink;
    }

    public UserDTO(String userId, String name, int roleId, String facebookId, String facebookLink) {
        this.userId = userId;
        this.name = name;
        this.roleId = roleId;
        this.facebookId = facebookId;
        this.link = facebookLink;
    }
    
    
    
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFacebookId() {
        return facebookId;
    }

    public void setFacebookId(String facebookId) {
        this.facebookId = facebookId;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }
}
