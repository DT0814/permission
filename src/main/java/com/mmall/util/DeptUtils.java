package com.mmall.util;

import com.mmall.dto.DeptLevelDto;

import java.util.ArrayList;
import java.util.List;

public class DeptUtils {
    public static List<DeptLevelDto> getDeptTree(int deptid, List<DeptLevelDto> dtos) {
        DeptLevelDto el = get(deptid, dtos);
        dtos = new ArrayList<>();
        dtos.add(el);
        return dtos;
    }

    private static DeptLevelDto get(int deptid, List<DeptLevelDto> dtos) {
        if (dtos == null && dtos.size() == 0) {
            return null;
        }
        DeptLevelDto res = null;
        for (DeptLevelDto dto : dtos) {
            if (dto.getId() == deptid) {
                res = dto;
                break;
            } else {
                res = get(deptid, dto.getDeptList());
                if (null!=res)break;
            }
        }
        return res;
    }

}
