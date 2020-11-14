<%--
  Created by IntelliJ IDEA.
  User: Ll
  Date: 2020/11/10
  Time: 19:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%
    //项目路径，用/开始的相对路径，从服务器路径开始，加上项目路径然后具体路径
    pageContext.setAttribute("ctp", request.getContextPath());
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工列表</title>
    <%--引入jQuery--%>
    <script type="text/javascript" src="${ctp}/static/js/jquery-1.9.1.min.js"></script>
    <%--引入样式--%>
    <link href="${ctp}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${ctp}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!--搭建显示页面-->
<div class="container">
    <!--标题-->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!--按钮-->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary btn-sm">新增</button>
            <button class="btn btn-danger btn-sm">删除</button>
        </div>
    </div>
    <!--表格-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                <c:forEach items="${pageInfo.list}" var="employee">
                    <tr>
                        <td>${employee.empId}</td>
                        <td>${employee.empName}</td>
                        <td>${employee.gender=="M"?"男":"女"}</td>
                        <td>${employee.email}</td>
                        <td>${employee.department.deptName}</td>
                        <td>
                            <button class="btn btn-primary btn-xs">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                编辑
                            </button>
                            <button class="btn btn-danger btn-xs">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                删除
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <!--分页信息-->
    <div class="row">
        <!--分页文字信息-->
        <div class="col-md-6">
            当前第&ensp;${pageInfo.pageNum}&ensp;页，
            总共&ensp;${pageInfo.pages}&ensp;页，
            总共&ensp;${pageInfo.total}&ensp;条记录
        </div>
        <!--分页条信息-->
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li>
                        <a href="${ctp}/emps?pn=1">首页</a>
                    </li>

                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li>
                            <a href="${ctp}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${!pageInfo.hasPreviousPage}">
                        <li class="disabled">
                            <span>
                                <span aria-hidden="true">&laquo;</span>
                            </span>
                        </li>
                    </c:if>

                    <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
                        <c:if test="${pageNum == pageInfo.pageNum}">
                            <li class="active">
                                <span>${pageNum}<span class="sr-only">(current)</span></span>
                            </li>
                        </c:if>
                        <c:if test="${pageNum != pageInfo.pageNum}">
                            <li><a href="${ctp}/emps?pn=${pageNum}">${pageNum}</a></li>
                        </c:if>
                    </c:forEach>

                    <c:if test="${pageInfo.hasNextPage}">
                        <li>
                            <a href="${ctp}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${!pageInfo.hasNextPage}">
                        <li class="disabled">
                            <span>
                                <span aria-hidden="true">&raquo;</span>
                            </span>
                        </li>
                    </c:if>

                    <li>
                        <a href="${ctp}/emps?pn=${pageInfo.pages}">末页</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>
