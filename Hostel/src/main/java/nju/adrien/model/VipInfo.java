package nju.adrien.model;

import javax.persistence.*;

@Entity
@Table(name = "vip_info", schema = "hostel")
public class VipInfo {
    private String vid;
    private String name;
    private String phone;
    private String state;
    private String password;
    private String bankid;

    private VipLevel level;

    public void defaultValue() {
        state = "invalid";
    }

    @Id
    @Column(name = "vid")
    public String getVid() {
        return vid;
    }

    public void setVid(String vid) {
        this.vid = vid;
    }

    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "phone")
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Column(name = "state")
    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    @Column(name = "password")
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Column(name = "bankid")
    public String getBankid() {
        return bankid;
    }

    public void setBankid(String bankid) {
        this.bankid = bankid;
    }

    @OneToOne
    @JoinColumn(name = "vid")
    public VipLevel getLevel() {
        return level;
    }

    public void setLevel(VipLevel level) {
        this.level = level;
    }

    @Override
    public String toString() {
        return "VipInfo{" +
                "vid='" + vid + '\'' +
                ", name='" + name + '\'' +
                ", phone='" + phone + '\'' +
                ", state='" + state + '\'' +
                ", password='" + password + '\'' +
                ", bankid='" + bankid + '\'' +
                ", level=" + level +
                '}';
    }
}
