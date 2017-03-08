package nju.adrien.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.sql.Date;

/**
 * Created by JiachenWang on 2017/3/7.
 */
@Entity
@Table(name = "book", schema = "hostel")
public class Book {
    private String bookid;
    private String vid;
    private String hid;
    private Date date;
    private String type;
    private int checkin;
    private double pay;

    @Id
    @Column(name = "bookid")
    public String getBookid() {
        return bookid;
    }

    public void setBookid(String bookid) {
        this.bookid = bookid;
    }

    @Column(name = "vid")
    public String getVid() {
        return vid;
    }

    public void setVid(String vid) {
        this.vid = vid;
    }

    @Column(name = "hid")
    public String getHid() {
        return hid;
    }

    public void setHid(String hid) {
        this.hid = hid;
    }

    @Column(name = "date")
    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    @Column(name = "type")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Column(name = "checkin")
    public int getCheckin() {
        return checkin;
    }

    public void setCheckin(int checkin) {
        this.checkin = checkin;
    }

    @Column(name = "pay")
    public double getPay() {
        return pay;
    }

    public void setPay(double pay) {
        this.pay = pay;
    }

    @Override
    public String toString() {
        return "Book{" +
                "bookid='" + bookid + '\'' +
                ", vid='" + vid + '\'' +
                ", hid='" + hid + '\'' +
                ", date=" + date +
                ", type='" + type + '\'' +
                ", checkin=" + checkin +
                ", pay=" + pay +
                '}';
    }
}
