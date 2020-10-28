/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jlp0011.dto;

import java.io.Serializable;

/**
 *
 * @author DELL
 */
public class CategoryDTO implements Serializable{
    private int categoryId;
    private String name;

    public CategoryDTO() {
    }

    public CategoryDTO(int categoryID, String name) {
        this.categoryId = categoryID;
        this.name = name;
    }

    public CategoryDTO(String name) {
        this.name = name;
    }
    
    

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    
}
