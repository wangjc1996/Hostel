package nju.adrien.vo;

import java.io.Serializable;

public class ShoppingCartItem implements Serializable {

    private int productId;
    private String productName;
    private double productPrice;
    private int productPoint;
    private int number;

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(double productPrice) {
        this.productPrice = productPrice;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public int getProductPoint() {
        return productPoint;
    }

    public void setProductPoint(int productPoint) {
        this.productPoint = productPoint;
    }
}
