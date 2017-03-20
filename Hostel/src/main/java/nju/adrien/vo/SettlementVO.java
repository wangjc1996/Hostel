package nju.adrien.vo;

/**
 * Created by JiachenWang on 2017/3/19.
 */
public class SettlementVO {
    private String month;
    private String hid;
    private String hname;
    private int number;
    private double amount;

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
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

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    @Override
    public String toString() {
        return "SettlementVO{" +
                "month=" + month +
                ", hid='" + hid + '\'' +
                ", hname='" + hname + '\'' +
                ", number=" + number +
                ", amount=" + amount +
                '}';
    }
}
