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
    private String planid;
    private int checkin;
    private double pay;
    private String names;

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

    @Column(name = "planid")
    public String getPlanid() {
        return planid;
    }

    public void setPlanid(String planid) {
        this.planid = planid;
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

    @Column(name = "names")
    public String getNames() {
        return names;
    }

    public void setNames(String names) {
        this.names = names;
    }

    @Override
    public String toString() {
        return "Book{" +
                "bookid='" + bookid + '\'' +
                ", vid='" + vid + '\'' +
                ", planid='" + planid + '\'' +
                ", checkin=" + checkin +
                ", pay=" + pay +
                ", names='" + names + '\'' +
                '}';
    }
}
