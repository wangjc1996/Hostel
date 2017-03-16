package nju.adrien.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "bank", schema = "hostel")
public class Bank {
    private String bankid;
    private String password;
    private double balance;

    @Column(name = "balance")
    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    @Id
    @Column(name = "bankid")
    public String getBankid() {
        return bankid;
    }

    public void setBankid(String bankid) {
        this.bankid = bankid;
    }

    @Column(name = "password")
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "Bank{" +
                "bankid='" + bankid + '\'' +
                ", password='" + password + '\'' +
                ", balance=" + balance +
                '}';
    }
}
