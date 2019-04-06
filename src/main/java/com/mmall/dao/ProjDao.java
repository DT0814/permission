package com.mmall.dao;

import com.mmall.model.SysProj;
import org.mybatis.spring.annotation.MapperScan;

import java.util.List;

@MapperScan
public interface ProjDao {
    SysProj getProjById(int id);

    SysProj getProjByFName(String fName);

    List<SysProj> getProjByLevel(int level);

    List<SysProj> getProjByUid(int uid);

    void insertProj(SysProj proj);

    int delectProj(int id);

    int  updatProjById(SysProj sysProj);

}
