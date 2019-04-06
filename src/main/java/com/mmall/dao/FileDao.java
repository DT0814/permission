package com.mmall.dao;

import org.mybatis.spring.annotation.MapperScan;
import com.mmall.model.File;

import java.util.List;

/**
 * Created by doter on 2017/7/16.
 */
@MapperScan
public interface FileDao {
    File getFileById(int id);
    File getFileByFName(String fName);
    List<File> getFileByPid(int pid);
    List<File> getFileByPidz(int pid);
    File getFileByUid(int uid);
    void insert(File bf);
    int delectFile(Integer id);
    void updateFile(File bf);
}
