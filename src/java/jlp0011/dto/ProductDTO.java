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
public class ProductDTO implements Serializable{
    private int productId;
    private String name;
    private String description;
    private int price;
    private int quantity;
    private int categoryId;
    private Date createDate;
    private Date expirationDate;
    private String image;
    private boolean status;

    public ProductDTO() {
    }

    public ProductDTO(int productId, String name, String description, int price, int quantity, int categoryId, Date createDate, Date expirationDate, String image, boolean status) {
        this.productId = productId;
        this.name = name;
        this.description = description;
        this.price = price;
        this.quantity = quantity;
        this.categoryId = categoryId;
        this.createDate = createDate;
        this.expirationDate = expirationDate;
        this.image = image;
        this.status = status;
    }

    
    public ProductDTO(int productId, String name, int price, int quantity, int categoryId, Date createDate, Date expirationDate, String image, boolean status) {
        this.productId = productId;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
        this.categoryId = categoryId;
        this.createDate = createDate;
        this.expirationDate = expirationDate;
        this.image = image;
        this.status = status;
    }

    public ProductDTO(String name, String description, int price, int quantity, int categoryId, Date createDate, Date expirationDate, String image) {
        this.name = name;
        this.description = description;
        this.price = price;
        this.quantity = quantity;
        this.categoryId = categoryId;
        this.createDate = createDate;
        this.expirationDate = expirationDate;
        this.image = image;
    }

    
    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getExpirationDate() {
        return expirationDate;
    }

    public void setExpirationDate(Date expirationDate) {
        this.expirationDate = expirationDate;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
    
}
