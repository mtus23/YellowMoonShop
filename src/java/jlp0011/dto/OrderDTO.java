/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jlp0011.dto;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 *
 * @author DELL
 */
public class OrderDTO implements Serializable{
    private String orderId;
    private String userId;
    private int total;
    private String phone;
    private String address;
    private Timestamp date;
    private String payment;
    private String name;
    private boolean paymentStatus;
    
    public OrderDTO() {
    }

    public OrderDTO(String orderId, String userId, int total, String phone, String address, Timestamp date, String payment, String name) {
        this.orderId = orderId;
        this.userId = userId;
        this.total = total;
        this.phone = phone;
        this.address = address;
        this.date = date;
        this.payment = payment;
        this.name = name;
    }

    public OrderDTO(int total, String phone, String address, Timestamp date, String name) {
        this.total = total;
        this.phone = phone;
        this.address = address;
        this.date = date;
        this.name = name;
    }

    public OrderDTO(String userId, int total, String phone, String address, Timestamp date, String name) {
        this.userId = userId;
        this.total = total;
        this.phone = phone;
        this.address = address;
        this.date = date;
        this.name = name;
    }

    public OrderDTO(String orderId, String userId, int total, String phone, String address, Timestamp date, String payment, String name, boolean paymentStatus) {
        this.orderId = orderId;
        this.userId = userId;
        this.total = total;
        this.phone = phone;
        this.address = address;
        this.date = date;
        this.payment = payment;
        this.name = name;
        this.paymentStatus = paymentStatus;
    }

    
    
    
    public String getPayment() {
        return payment;
    }

    public void setPayment(String payment) {
        this.payment = payment;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
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

    public boolean isPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(boolean paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    
    
    
}
