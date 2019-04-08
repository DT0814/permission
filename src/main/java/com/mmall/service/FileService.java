package com.mmall.service;

import javax.annotation.Resource;
import com.mmall.dao.FileDao;
import com.mmall.model.File;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("fileService")
public class FileService{
    @Resource
    FileDao fileDao;
    //   @Resource
    //  PassageDao passageDao;
    public File getFileById(int id) {
        // TODO Auto-generated method stub
        return fileDao.getFileById(id);
    }


    public List<File> getFileByPid(int pid) {
        ;        return  fileDao.getFileByPid(pid);
    }
    public List<File> getFileByPidz(int pid,int uid) {
        Map map=new HashMap();
        map.put("pid",pid);
        map.put("uid",uid);
       return  fileDao.getFileByPidz(map);
    }
    public File upload(File f) {
        fileDao.insert(f);
        return f;
    }


    public int delectFile(Integer id) {
        return fileDao.delectFile(id);
    }


}
