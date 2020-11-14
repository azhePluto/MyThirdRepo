package com.hnust.crud.controller;

import com.hnust.crud.bean.Department;
import com.hnust.crud.bean.Msg;
import com.hnust.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/* @Ll
 * @2020/11/12 8:47
 *
 * 处理和部门有关的请求
 */
@Controller
public class DepartmentController {

    @Autowired
    DepartmentService departmentService;

    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts() {
        List<Department> depts = departmentService.getDepts();
        return Msg.success().add("depts", depts);
    }

}
