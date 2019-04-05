package com.mmall.model;

import java.util.Date;

public class File {
    private Integer id;
    private Integer uid;
    private String fname;
    private String location;
    private Long size;
    private Integer pid;
    private Integer pfid;
    private Integer type;
    private java.util.Date startdate;
    private String filename;//查询映射用
    private String fid;//查询映射用,表示文件id

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }


    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Long getSize() {
        return size;
    }

    public void setSize(Long size) {
        this.size = size;
    }

    public Integer gettype() {
        return type;
    }

    public void settype(Integer type) {
        this.type = type;
    }

    public Date getStartdate() {
        return startdate;
    }

    public void setStartdate(Date startdate) {
        this.startdate = startdate;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String toString() {

        return "location：" + getLocation() +" "+
                "id：" + getId() +" "+ "uid：" + getUid() + " "+"pid：" + getPid() +" "+ "sicze:" + getSize() + " "+
                "Startdate:" + getStartdate() + "type" + gettype();
    }


    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public Integer getPfid() {
        return pfid;
    }

    public void setPfid(Integer pfid) {
        this.pfid = pfid;
    }


    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public String getFid() {
        return fid;
    }

    public void setFid(String fid) {
        this.fid = fid;
    }
}
