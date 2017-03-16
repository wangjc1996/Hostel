package nju.adrien.vo;

public class IndexProduct {

    private String hid;
    private String name;
    private String location;
    private String phone;
    private String imgPath;

    public IndexProduct() {
        this.imgPath = "/assets/img/product.jpg";
    }

    public IndexProduct(String hid, String name, String location, String phone) {
        this.hid = hid;
        this.name = name;
        this.location = location;
        this.phone = phone;
        this.imgPath = "/assets/img/product.jpg";
    }

    public String getHid() {
        return hid;
    }

    public void setHid(String hid) {
        this.hid = hid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    @Override
    public String toString() {
        return "IndexProduct{" +
                "hid='" + hid + '\'' +
                ", name='" + name + '\'' +
                ", location='" + location + '\'' +
                ", phone='" + phone + '\'' +
                ", imgPath='" + imgPath + '\'' +
                '}';
    }
}
