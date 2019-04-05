package com.mmall.service;

import com.mmall.dao.ProjTypeDao;
import com.mmall.dao.SysDeptMapper;
import com.mmall.dao.SysUserMapper;
import com.mmall.model.SysProjType;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;
@Service
public class ProjTypeService {
    @Resource
    ProjTypeDao projTypeDao;

    //   @Resource
    //  PassageDao passageDao;
    public SysProjType getProjById(int id) {
        // TODO Auto-generated method stub
        return projTypeDao.getProjTypeById(id);
    }
    public void updatProjById(SysProjType sysProjType) {
        // TODO Auto-generated method stub
        projTypeDao.updatProjTypeById(sysProjType);
    }
    public void insertProj(SysProjType sysProjType) {
        // TODO Auto-generated method stub
        System.out.println(sysProjType.getName());
     //   System.out.println(sysProjType.getFilename1());
        System.out.println(sysProjType.getDeleted());
        System.out.println(sysProjType.getStartdate());
        projTypeDao.insertProjType(sysProjType);
    }
    public List<SysProjType> getProjTypeByDeleted() {
        // TODO Auto-generated method stub
        //  sys_project.name,sys_project.descr,sys_project.startdate,sys_user.username,sys_dept.name
        return  projTypeDao.getProjTypeByDeleted();
    }

    public int delectProjType(Integer id) {
        return projTypeDao.delectProjType(id);
    }
}
