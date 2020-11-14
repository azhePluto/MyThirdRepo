package com.hnust.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hnust.crud.bean.Employee;
import com.hnust.crud.bean.Msg;
import com.hnust.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.*;

/* @Ll
 * @2020/11/10 19:15
 *
 * 处理员工CRUD请求
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /*
    * 单个批量二合一
    * */
    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteById(@PathVariable("ids") String ids) {
        //批量删除
        if (ids.contains("-")) {
            List<Integer> idList = new ArrayList<>();
            String[] Str_ids = ids.split("-");
            for (String string : Str_ids) {
                idList.add(Integer.parseInt(string));
            }
            employeeService.batchDelete(idList);
        } else {
            //单个删除
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }

    /*
    * 更新方法
    * 如果直接发送ajax=PUT形式的请求
    * 封装的数据只会带上路径中有的empId
    *
    * 问题：请求体中有数据，employee对象封装不上
    * 1、tomcat将请求体中的数据，封装一个map
    * 2、request.getParameter("empName")就会从这个map中取值
    * 3、SpringMVC封装POJO对象的时候
    *   会把POJO中每个属性的值getParameter
    * 原因：
    * AJAX发送PUT请求，请求体中的数据getParameter拿不到
    * tomcat不会封装请求体中的数据，只有POST形式的请求才封装请求体为map
    * org.apache.catalina.connector.Request--parseParameters()（3000行左右）
    * protected String parseBodyMethod = "POST";//只有POST请求才会解析请求体
    * if (!getConnector().isParseBodyMethod(getMethod())) {
    *   success = true;
    *   return;
    * }
    * 要直接使用ajax发送PUT请求，还需要封装请求体中的数据时
    * 配置一个过滤器FormContentFilter
    * 将请求体中的数据解析包装成map
    * request被重新包装，request.getParameter()被重写，就会从自己封装的map中取数据
    * */
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(Employee employee){
        System.out.println(employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /*
    * 按照员工id查员工
    * */
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id) {
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }

    /*
    * 员工保存
    * 1、支持JSR303校验
    * 2、导入Hibernate-Validator
    * */
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            //校验失败，应该返回失败，在模态框中显示校验失败的错误信息；
            Map<String, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError error : errors) {
                System.out.println("错误字段名" + error.getField());
                System.out.println("错误信息" + error.getDefaultMessage());
                map.put(error.getField(), error.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        }else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    /*
    * 检查用户名是否可用
    * */
    @RequestMapping("/checkUser")
    @ResponseBody
    public Msg checkUser(String empName) {
        if (empName == null) return Msg.fail();
        //if (empName.length() < 2 || empName.length() > 16) return Msg.illegal();
        //先判断用户名是否合法
        String regx= "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)";
        if (!empName.matches(regx)) {
            return Msg.illegal();
        }
        //数据库用户名重复校验
        boolean b = employeeService.checkUser(empName);
        return b?Msg.success():Msg.fail();
    }

    /*
    * 导入jackson包
    * */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 10);
        List<Employee> emps = employeeService.getAll();
        PageInfo<Employee> pageInfo = new PageInfo<>(emps, 5);
        return Msg.success().add("pageInfo", pageInfo);
    }

    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
                          Model model) {
        //这不是一个分页查询
        //引入pageHelper分页插件
        //在查询之前只需要调用↓，传入页码，以及每一页的大小
        PageHelper.startPage(pn, 5);
        //startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        //使用PageInfo包装查询结果，只需要将pageInfo交给页面
        //封装了信息的分页信息，包括有我们查询出来的数据，可设置连续显示的页数
        PageInfo<Employee> page = new PageInfo<>(emps, 5);
        model.addAttribute("pageInfo", page);
        return "list";
    }

}
