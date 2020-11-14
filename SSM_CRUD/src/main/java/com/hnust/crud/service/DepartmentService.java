package com.hnust.crud.service;

import com.hnust.crud.bean.Department;
import com.hnust.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/* @Ll
 * @2020/11/12 8:48
 *
 *
 */
@Service
public class DepartmentService {

    @Autowired
    DepartmentMapper departmentMapper;

    public List<Department> getDepts() {
        return departmentMapper.selectByExample(null);
    }

}
