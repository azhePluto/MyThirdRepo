package com.hnust.crud.test;

import com.hnust.crud.dao.DepartmentMapper;
import com.hnust.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/* @Ll
 * @2020/11/10 18:51
 *
 * 测试dao层的工作
 * 使用Spring单元测试，可以自动注入我们需要的组件
 * @ContextConfiguration指定Spring配置文件位置
 * @RunWith(SpringJUnit4ClassRunner.class)指定使用的测试器
 * 可以@Autowired自动注入mapper了
 */
@ContextConfiguration("classpath:applicationContext.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    /*
    * 测试DepartmentMapper
    * */
    @Test
    public void testCRUD() {
        //1、插入几个部门
        //departmentMapper.insertSelective(new Department(null, "开发部"));
        //departmentMapper.insertSelective(new Department(null, "测试部"));
        //2、生成员工数据，测试员工插入
        //employeeMapper.insertSelective(new Employee(null, "Jerry", "M", "Jerry@hnust.com", 1));
        //3、批量插入多个员工；批量，使用可以执行批量操作的sqlSession
        /*
        * for(){
        *   employeeMapper.insertSelective(new Employee(null, UUID, "M", "Jerry@hnust.com", 1));
        * }
        * */
        /*EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++){
            String name = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(null, name, "M", name + "@hnust.com",1));
        }*/
    }

}
