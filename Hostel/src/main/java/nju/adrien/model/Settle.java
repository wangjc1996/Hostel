package nju.adrien.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "settle", schema = "hostel")
public class Settle {
    private String month;
    private int hasSettled;

    @Id
    @Column(name = "month")
    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    @Column(name = "hasSettled")
    public int getHasSettled() {
        return hasSettled;
    }

    public void setHasSettled(int hasSettled) {
        this.hasSettled = hasSettled;
    }

    @Override
    public String toString() {
        return "Settle{" +
                "month='" + month + '\'' +
                ", hasSettled=" + hasSettled +
                '}';
    }
}
