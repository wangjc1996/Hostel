package nju.adrien.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by JiachenWang on 2017/3/18.
 */
@Entity
@Table(name = "cash", schema = "hostel")
public class Cash {
    private String cashid;
    private String planid;
    private double amount;
    private String bookid;
    private String names;

    @Id
    @Column(name = "cashid")
    public String getCashid() {
        return cashid;
    }

    public void setCashid(String cashid) {
        this.cashid = cashid;
    }

    @Column(name = "planid")
    public String getPlanid() {
        return planid;
    }

    public void setPlanid(String planid) {
        this.planid = planid;
    }

    @Column(name = "amount")
    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    @Column(name = "bookid")
    public String getBookid() {
        return bookid;
    }

    public void setBookid(String bookid) {
        this.bookid = bookid;
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
        return "Cash{" +
                "cashid='" + cashid + '\'' +
                ", planid='" + planid + '\'' +
                ", amount='" + amount + '\'' +
                ", bookid='" + bookid + '\'' +
                ", names='" + names + '\'' +
                '}';
    }
}
