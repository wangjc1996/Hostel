package nju.adrien.vo;

/**
 * Created by JiachenWang on 2017/3/19.
 */
public class FinanceVO {
    private double vipAccount;
    private double vipCash;
    private double nonVipCash;

    public double getVipAccount() {
        return vipAccount;
    }

    public void setVipAccount(double vipAccount) {
        this.vipAccount = vipAccount;
    }

    public double getVipCash() {
        return vipCash;
    }

    public void setVipCash(double vipCash) {
        this.vipCash = vipCash;
    }

    public double getNonVipCash() {
        return nonVipCash;
    }

    public void setNonVipCash(double nonVipCash) {
        this.nonVipCash = nonVipCash;
    }

    @Override
    public String toString() {
        return "FinanceVO{" +
                "vipAccount=" + vipAccount +
                ", vipCash=" + vipCash +
                ", nonVipCash=" + nonVipCash +
                '}';
    }
}
