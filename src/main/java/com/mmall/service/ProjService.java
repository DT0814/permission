package com.mmall.service;

import com.mmall.dao.ProjDao;
import com.mmall.dao.SysDeptMapper;
import com.mmall.dao.SysUserMapper;
import com.mmall.model.SysDept;
import com.mmall.model.SysProj;
import com.mmall.model.SysUser;
import org.springframework.expression.spel.ast.Projection;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;

@Service
public class ProjService {
    @Resource
    ProjDao projDao;
    @Resource
    SysUserMapper sysUserMapper;
    @Resource
    SysDeptMapper sysDeptMapper;

    //   @Resource
    //  PassageDao passageDao;
    public List<SysProj> getProjById(int id) {
        // TODO Auto-generated method stub
        return projDao.getProjByUid(id);
    }
    public void updatProjById(SysProj sysProj) {
        // TODO Auto-generated method stub
        projDao.updatProjById(sysProj);
    }
    public void insertProj(SysProj proj) {
        // TODO Auto-generated method stub
         projDao.insertProj(proj);
    }
    public  List<SysProj> getProjByLevel(int level) {
        // TODO Auto-generated method stub
      //  sys_project.name,sys_project.descr,sys_project.startdate,sys_user.username,sys_dept.name
        return  projDao.getProjByLevel(level);
    }

    public int delectProj(Integer id) {
        return projDao.delectProj(id);
    }
    public SysProj getOneProj(Integer id)
    {
        return projDao.getProjById(id);
    }
}
