package nju.adrien.vo;

import nju.adrien.model.HotelPlan;

import java.sql.Date;

/**
 * Created by JiachenWang on 2017/3/18.
 */
public class StatisticVO {

    private String planid;
    private String hid;
    private Date date;
    private String type;
    private double price;
    private int available;
    private int bookTotal;
    private int bookCheckin;
    private int nonBookCheckin;

    public StatisticVO() {
    }

    public StatisticVO(HotelPlan plan) {
        this.planid = plan.getPlanid();
        this.hid = plan.getHid();
        this.date = plan.getDate();
        this.type = plan.getType();
        this.price = plan.getPrice();
        this.available = plan.getAvailable();
    }

    public String getPlanid() {
        return planid;
    }

    public void setPlanid(String planid) {
        this.planid = planid;
    }

    public String getHid() {
        return hid;
    }

    public void setHid(String hid) {
        this.hid = hid;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getAvailable() {
        return available;
    }

    public void setAvailable(int available) {
        this.available = available;
    }

    public int getBookTotal() {
        return bookTotal;
    }

    public void setBookTotal(int bookTotal) {
        this.bookTotal = bookTotal;
    }

    public int getBookCheckin() {
        return bookCheckin;
    }

    public void setBookCheckin(int bookCheckin) {
        this.bookCheckin = bookCheckin;
    }

    public int getNonBookCheckin() {
        return nonBookCheckin;
    }

    public void setNonBookCheckin(int nonBookCheckin) {
        this.nonBookCheckin = nonBookCheckin;
    }

    @Override
    public String toString() {
        return "StatisticVO{" +
                "planid='" + planid + '\'' +
                ", hid='" + hid + '\'' +
                ", date=" + date +
                ", type='" + type + '\'' +
                ", price=" + price +
                ", available=" + available +
                ", bookTotal=" + bookTotal +
                ", bookCheckin=" + bookCheckin +
                ", nonBookCheckin=" + nonBookCheckin +
                '}';
    }
}
