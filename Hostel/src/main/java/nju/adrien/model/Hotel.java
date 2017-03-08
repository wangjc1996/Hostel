package nju.adrien.model;

import javax.persistence.*;
import java.util.Set;

/**
 * Created by JiachenWang on 2017/3/7.
 */
@Entity
@Table(name = "hotel_info", schema = "hostel")
public class Hotel {
    private String hid;
    private String name;
    private String location;
    private String phone;

    private Set<HotelPlan> hotelPlan;

    @Id
    @Column(name = "hid")
    @GeneratedValue//主键用自增序列
    public String getHid() {
        return hid;
    }

    public void setHid(String hid) {
        this.hid = hid;
    }

    @Basic
    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "location")
    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    @Basic
    @Column(name = "phone")
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @OneToMany(mappedBy = "hid", cascade = CascadeType.ALL)
    public Set<HotelPlan> getHotelPlan() {
        return hotelPlan;
    }

    public void setHotelPlan(Set<HotelPlan> hotelPlan) {
        this.hotelPlan = hotelPlan;
    }

    @Override
    public String toString() {
        StringBuffer buffer = new StringBuffer();
        buffer.append("Hotel{");
        buffer.append("hid='" + hid + '\'');
        buffer.append( ", name='" + name + '\'');
        buffer.append(", location='" + location + '\'');
        buffer.append(", phone='" + phone + '\'');
        buffer.append(", hotelPlan=" + "\n");
        for (HotelPlan plan : hotelPlan){
            buffer.append("\t");
            buffer.append(plan + "\n");
        }
        buffer.append('}' + "\n");
        return buffer.toString();
    }
}
