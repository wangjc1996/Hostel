package nju.adrien.vo;

import java.sql.Date;

public class BillVO {
    private Date date;
    private String type;
    private String bookid;
    private String cashid;
    private String names;
    private double amount;

    public BillVO(Date date, String type, String bookid, String cashid, String names, double amount) {
        this.date = date;
        this.type = type;
        this.bookid = bookid;
        this.cashid = cashid;
        this.names = names;
        this.amount = amount;
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

    public String getBookid() {
        return bookid;
    }

    public void setBookid(String bookid) {
        this.bookid = bookid;
    }

    public String getCashid() {
        return cashid;
    }

    public void setCashid(String cashid) {
        this.cashid = cashid;
    }

    public String getNames() {
        return names;
    }

    public void setNames(String names) {
        this.names = names;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    @Override
    public String toString() {
        return "BillVO{" +
                "date=" + date +
                ", type='" + type + '\'' +
                ", bookid='" + bookid + '\'' +
                ", cashid='" + cashid + '\'' +
                ", names='" + names + '\'' +
                ", amount=" + amount +
                '}';
    }
}
