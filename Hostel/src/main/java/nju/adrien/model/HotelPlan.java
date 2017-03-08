package nju.adrien.model;

/**
 * Created by JiachenWang on 2017/3/7.
 */

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.sql.Date;

@Entity
@Table(name = "hotel_plan", schema = "hostel")
public class HotelPlan implements Serializable {
    private String hid;
    private Date date;
    private String type;
    private double price;
    private int available;

    @Id
    @Column(name = "hid")
    public String getHid() {
        return hid;
    }

    public void setHid(String hid) {
        this.hid = hid;
    }

    @Id
    @Column(name = "date")
    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    @Id
    @Column(name = "type")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Column(name = "price")
    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Column(name = "available")
    public int getAvailable() {
        return available;
    }

    public void setAvailable(int available) {
        this.available = available;
    }

    @Override
    public String toString() {
        return "HotelPlan{" +
                "hid='" + hid + '\'' +
                ", date=" + date +
                ", type='" + type + '\'' +
                ", price=" + price +
                ", available=" + available +
                '}';
    }
}
