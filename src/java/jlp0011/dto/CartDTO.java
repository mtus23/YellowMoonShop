/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jlp0011.dto;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author DELL
 */
public class CartDTO implements Serializable{
    private Map<ProductDTO, Integer> items;
    
    public Map<ProductDTO, Integer> getItems(){
        return items;
    }
    
    public int getTotalPrice(){
        int total=0;
        if(this.items != null){
            for(ProductDTO dto : items.keySet()){
                total += (dto.getPrice()*this.items.get(dto));
            }
        }
        return total;
    }
    
    private ProductDTO searchForProductInfo(int id) {
        for (ProductDTO dto : items.keySet()) {
            if (dto.getProductId() == id) {
                return dto;
            }
        }
        return null;
    }

    public void addProductToCart(ProductDTO product, int quantity) {
        if (this.items == null) {
            this.items = new HashMap<>();
        }

        ProductDTO dto = searchForProductInfo(product.getProductId());
        if (dto == null) {
            this.items.put(product, quantity);
        } else {
            int total = this.items.get(dto);
            this.items.put(dto, total + quantity);
        }
    }

    public void updateProductFromCart(int proId, int quantity) {
        if (this.items == null) {
            this.items = new HashMap<>();
        }

        ProductDTO dto = searchForProductInfo(proId);
        if (dto != null) {
            this.items.put(dto, quantity);
        }
    }

    public void removeProductFromCart(int proId) {
        if (this.items == null) {
            return;
        }
        ProductDTO dto = searchForProductInfo(proId);
        if (dto != null) {
            this.items.remove(dto);

            if (this.items.isEmpty()) {
                this.items = null;
            }
        }
    }

    public void clearCart() {
        if (this.items != null) {
            items = null;
        }
    }
}
