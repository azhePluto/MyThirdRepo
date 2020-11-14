package com.hnust.crud.test;

import com.github.pagehelper.PageInfo;
import com.hnust.crud.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/* @Ll
 * @2020/11/10 19:30
 *
 * 使用Spring测试模块提供的测试请求功能，测试crud请求的正确性
 * java.lang.NoClassDefFoundError: javax/servlet/SessionCookieConfig
 * Spring4测试的时候，需要servlet3.0的支持
 */
@ContextConfiguration(locations = {"classpath:applicationContext.xml",
        "classpath:dispatcherServlet-servlet.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
public class MVCTest {
    //传入SpringMVC的ioc容器
    @Autowired
    WebApplicationContext context;

    //虚拟MVC请求，获取到处理结果
    MockMvc mockMvc;

    @Before
    public void initMockMvc() {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        //模拟请求，拿到返回值
        MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "6")).andReturn();
        //请求成功以后，请求域中会有pageInfo；我们可以去除pageInfo进行验证
        MockHttpServletRequest request = mvcResult.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码：" + pageInfo.getPageNum());
        System.out.println("总页码：" + pageInfo.getPages());
        System.out.println("总记录数：" + pageInfo.getTotal());
        System.out.println("在页面需要连续显示的页码");
        int[] nums = pageInfo.getNavigatepageNums();
        for (int i : nums) {
            System.out.print("  " + i);
        }
        System.out.println("员工数据：");
        List<Employee> list = pageInfo.getList();
        for (Employee employee :
                list) {
            System.out.println(employee);
        }
    }

}
