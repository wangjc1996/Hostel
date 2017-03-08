package nju.adrien.model;

import javax.persistence.*;
import java.sql.Date;

@Entity
@Table(name = "vip_level", schema = "hostel")
public class VipLevel {
    private String vid;
    private String level;
    private double discount;
    private double balance;
    private double integration;
    private Date time;

    @Id
    @Column(name = "vid")
    public String getVid() {
        return vid;
    }

    public void setVid(String vid) {
        this.vid = vid;
    }

    @Column(name = "level")
    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    @Column(name = "discount")
    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    @Column(name = "balance")
    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    @Column(name = "integration")
    public double getIntegration() {
        return integration;
    }

    public void setIntegration(double integration) {
        this.integration = integration;
    }

    @Column(name = "time")
    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    @Override
    public String toString() {
        return "VipLevel{" +
                "vid='" + vid + '\'' +
                ", level='" + level + '\'' +
                ", discount=" + discount +
                ", balance=" + balance +
                ", integration=" + integration +
                ", time=" + time +
                '}';
    }
}
