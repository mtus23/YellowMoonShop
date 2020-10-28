/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jlp0011.dto;

import java.io.Serializable;
import java.sql.Date;

/**
 *
 * @author DELL
 */
public class LogDTO implements Serializable{
    private int logId;
    private String userId;
    private int productId;
    private Date date;
    private boolean status;

    public LogDTO() {
    }

    public LogDTO(int logId, String userId, int productId, Date date, boolean status) {
        this.logId = logId;
        this.userId = userId;
        this.productId = productId;
        this.date = date;
        this.status = status;
    }

    public LogDTO(int logId, String userId, int productId, Date date) {
        this.logId = logId;
        this.userId = userId;
        this.productId = productId;
        this.date = date;
    }

    public LogDTO(String userId, int productId, Date date) {
        this.userId = userId;
        this.productId = productId;
        this.date = date;
    }

    

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    

    public int getLogId() {
        return logId;
    }

    public void setLogId(int logId) {
        this.logId = logId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    
}