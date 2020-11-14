package com.hnust.crud.service;

import com.hnust.crud.bean.Employee;
import com.hnust.crud.bean.EmployeeExample;
import com.hnust.crud.bean.EmployeeExample.Criteria;
import com.hnust.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/* @Ll
 * @2020/11/10 19:17
 *
 *
 */
@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    /*
    * 查询所有员工
    * */
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    //员工保存
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    //检验用户名是否可用，返回true可用
    public boolean checkUser(String empName) {
        EmployeeExample example = new EmployeeExample();
        Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(example);
        return count == 0;
    }

    public Employee getEmp(Integer id) {
        return employeeMapper.selectByPrimaryKey(id);
    }

    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void batchDelete(List<Integer> idList) {
        EmployeeExample example = new EmployeeExample();
        Criteria criteria = example.createCriteria();
        criteria.andEmpIdIn(idList);
        employeeMapper.deleteByExample(example);
    }

}
