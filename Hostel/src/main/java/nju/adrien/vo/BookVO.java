package nju.adrien.vo;

import nju.adrien.model.Book;

import java.sql.Date;

public class BookVO {

    private String bookid;
    private String planid;
    private String vid;
    private String hid;
    private String hname;
    private String names;
    private Date date;
    private String type;
    private double price;
    private int checkin;

    public String getBookid() {
        return bookid;
    }

    public void setBookid(String bookid) {
        this.bookid = bookid;
    }

    public String getPlanid() {
        return planid;
    }

    public void setPlanid(String planid) {
        this.planid = planid;
    }

    public String getVid() {
        return vid;
    }

    public void setVid(String vid) {
        this.vid = vid;
    }

    public String getHid() {
        return hid;
    }

    public void setHid(String hid) {
        this.hid = hid;
    }

    public String getHname() {
        return hname;
    }

    public void setHname(String hname) {
        this.hname = hname;
    }

    public String getNames() {
        return names;
    }

    public void setNames(String names) {
        this.names = names;
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

    public int getCheckin() {
        return checkin;
    }

    public void setCheckin(int checkin) {
        this.checkin = checkin;
    }

    /**
     * 没有设置bookid
     *
     * @return
     */
    public Book toBook() {
        Book book = new Book();
        book.setVid(vid);
        book.setPlanid(planid);
        book.setCheckin(0);
        book.setPay(price);
        book.setNames(names);
        return book;
    }

    @Override
    public String toString() {
        return "BookVO{" +
                "bookid='" + bookid + '\'' +
                ", planid='" + planid + '\'' +
                ", vid='" + vid + '\'' +
                ", hid='" + hid + '\'' +
                ", hname='" + hname + '\'' +
                ", names='" + names + '\'' +
                ", date=" + date +
                ", type='" + type + '\'' +
                ", price=" + price +
                ", checkin=" + checkin +
                '}';
    }
}
