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
    <style type="text/css">
        a {
            user-select: none;
        }

        thead {
            user-select: none;
        }

        form {
            user-select: none;
        }
    </style>
</head>
<body>

<!-- 员工添加模态框Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input autocomplete="off" type="text" name="empName" class="form-control"
                                   id="empName_add_input"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input autocomplete="off" type="email" name="email" class="form-control"
                                   id="email_add_input"
                                   placeholder="email@hnust.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">depts</label>
                        <label class="col-sm-4">
                            <select id="dept_add_select" class="form-control" name="dId">

                            </select>
                        </label>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 员工修改模态框Modal -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p id="empName_update_static" class="form-control-static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_update_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input autocomplete="off" type="email" name="email" class="form-control"
                                   id="email_update_input"
                                   placeholder="email@hnust.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked">
                                男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">depts</label>
                        <label class="col-sm-4">
                            <select id="dept_update_select" class="form-control" name="dId">

                            </select>
                        </label>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>


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
            <button id="emp_add_model" class="btn btn-primary btn-sm">新增</button>
            <button id="emp_delete_all_btn" class="btn btn-danger btn-sm">删除</button>
        </div>
    </div>
    <!--表格-->
    <div class="row">
        <div class="col-md-12">
            <table id="emps_table" class="table table-hover">
                <thead>
                <tr>
                    <th>
                        <input id="checkAll" type="checkbox"/>
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <!--分页信息-->
    <div class="row">
        <!--分页文字信息-->
        <div id="page_info_area" class="col-md-6">
        </div>
        <!--分页条信息-->
        <div id="page_nav_area" class="col-md-6">
        </div>
    </div>
</div>
<script type="text/javascript">
    let totalRecord, currentPage;
    //1、页面加载完成以后，直接去发送一个ajax请求，要到分页数据
    $(function () {
        toPage(1)
    });

    function toPage(pn) {
        $.ajax({
            url: "${ctp}/emps",
            data: "pn=" + pn,
            type: "get",
            success: function (result) {
                //console.log(result);
                //1、解析并显示员工数据
                build_emps_table(result);
                //2、解析并显示分页信息
                build_page_info(result);
                //3、解析并显示分页条
                build_page_nav(result);
            }
        });
        $("#checkAll").prop("checked", false);
    };

    function build_emps_table(result) {
        $("#emps_table tbody").empty();
        let emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            //alert(item.empName);
            let checkBoxDiv = $("<div class='checkbox'></div>");
            let checkBoxInput = $("<input type='checkbox' class='check_item'/>");
            checkBoxDiv.append(checkBoxInput);
            let checkBoxTd = $("<td></td>").append(checkBoxInput);
            let empIdTd = $("<td></td>").append(item.empId);
            let empNameTd = $("<td></td>").append(item.empName);
            let empGenderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
            let empEmailTd = $("<td></td>").append(item.email);
            let deptNameTd = $("<td></td>").append(item.department.deptName);
            let editBtn = $("<button></button>").addClass("btn btn-primary btn-xs edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("编辑");
            editBtn.attr("edit-id", item.empId);
            let deleteBtn = $("<button></button>").addClass("btn btn-danger btn-xs delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除");
            deleteBtn.attr("delete-id", item.empId);
            let btnTd = $("<td></td>").append(editBtn).append(" ").append(deleteBtn);
            //append执行完以后还是返回用来的元素
            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(empGenderTd)
                .append(empEmailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }

    function build_page_info(result) {
        $("#page_info_area").empty().append("当前第 " +
            result.extend.pageInfo.pageNum + " 页，总共 " +
            result.extend.pageInfo.pages + " 页，总共 " +
            result.extend.pageInfo.total + " 条记录")
        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }

    function build_page_nav(result) {
        $("#page_nav_area").empty();
        let ul = $("<ul></ul>").addClass("pagination");
        let firstPageLi = $("<li></li>").append($("<a></a>").append("首页"));
        let prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (!result.extend.pageInfo.hasPreviousPage) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            firstPageLi.click(function () {
                toPage(1);
            });
            prePageLi.click(function () {
                toPage(result.extend.pageInfo.pageNum - 1);
            });
        }
        let nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        let lastPageLi = $("<li></li>").append($("<a></a>").append("末页"));
        if (!result.extend.pageInfo.hasNextPage) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                toPage(result.extend.pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                toPage(result.extend.pageInfo.pages);
            });
        }

        ul.append(firstPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            let numLi = $("<li></li>").append($("<a></a>").append(item));
            if (item == result.extend.pageInfo.pageNum) {
                numLi.addClass("active");
            } else {
                numLi.click(function () {
                    toPage(item);
                });
            }
            ul.append(numLi);
        });
        ul.append(nextPageLi).append(lastPageLi);
        let navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

    $("#emp_add_model").click(function () {
        $("#empAddModal form")[0].reset();
        show_validate_msg("#empName_add_input", "", "");
        show_validate_msg("#email_add_input", "", "");
        //发送ajax请求，查出部门信息，显示在下拉列表中
        getDepts("#dept_add_select");

        //弹出模态框
        $("#empAddModal").modal({
            backdrop: "static"
        });
    });

    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url: "${ctp}/depts",
            type: "GET",
            async: false,
            success: function (result) {
                //console.log(result);
                //$("#dept_add_select").append($("<option></option>"))
                $.each(result.extend.depts, function () {
                    let optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    function validate_add_form() {
        //1、拿到要校验的数据，正则表达式
        let empName = $("#empName_add_input").val();
        let regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
        if (!regName.test(empName)) {
            //alert("用户名可以是2-5位中文或者字母数字组合6-16位");
            $("#emp_save_btn").attr("ajax-va", "error");
            show_validate_msg("#empName_add_input", "error", "用户名可以是2-5位中文或者字母数字组合6-16位");
            return false;
        } else {
            $("#emp_save_btn").attr("ajax-va", "success");
            show_validate_msg("#empName_add_input", "success", "");
        }
        let email = $("#email_add_input").val();
        let regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            //alert("邮箱格式不正确");
            $("#emp_save_btn").attr("ajax-va", "error");
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确")
            return false;
        } else {
            $("#emp_save_btn").attr("ajax-va", "success");
            show_validate_msg("#email_add_input", "success", "")
        }
        return true;
    }

    function show_validate_msg(ele, status, msg) {
        //清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
        }
        $(ele).next("span").text(msg);
    }

    $("#empName_add_input").on("input", function () {
        let empName = $("#empName_add_input").val();
        $.ajax({
            url: "checkUser",
            type: "get",
            data: "empName=" + empName,
            success: function (result) {
                if (result.code == 100) {
                    $("#emp_save_btn").attr("ajax-va", "success");
                    show_validate_msg("#empName_add_input", "success", "用户名可用");
                } else if (result.code == 200) {
                    $("#emp_save_btn").attr("ajax-va", "error");
                    show_validate_msg("#empName_add_input", "error", "用户名已被使用");
                } else {
                    $("#emp_save_btn").attr("ajax-va", "error");
                    show_validate_msg("#empName_add_input", "error", "用户名可以是2-5位中文或者字母数字组合6-16位");
                }
            }
        });
    });

    $("#emp_save_btn").click(function () {
        //判断之前的ajax用户名校验是否成功了，如果成功了往下继续走
        let check = $(this).attr("ajax-va");
        if (check == "error") {
            return false;
        }
        //校验表单数据
        if (!validate_add_form()) {
            return false;
        }
        //1、模态框中填写的表单数据提交给服务器进行保存
        $.ajax({
            url: "${ctp}/emp",
            type: "post",
            data: $("#empAddModal form").serialize(),
            success: function (result) {
                //alert(result.msg);
                /*
                员工保存成功
                1、关闭模态框
                2、来到最后一页，显示刚才保存的数据，发送ajax请求
                */
                if (result.code == 100) {
                    $('#empAddModal').modal('hide');
                    toPage(totalRecord);
                } else {
                    //显示失败信息
                    if (undefined != result.extend.errorFields.email) {
                        $("#emp_save_btn").attr("ajax-va", "error");
                        show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                    }
                    if (undefined != result.extend.errorFields.empName) {
                        $("#emp_save_btn").attr("ajax-va", "error");
                        show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
                    }
                }
            }
        });
    });

    //1、按钮创建之前就绑定了click，所以绑定不上，
    //2、可以在创建按钮的时候绑定时间
    $(document).on("click", ".edit_btn", function () {
        //alert("edit");
        //查询员工信息，显示在模态框

        //发送ajax请求，查出部门信息，显示在下拉列表中
        getDepts("#dept_update_select");
        getEmp($(this).attr("edit-id"));
        //弹出模态框
        $("#empUpdateModal").modal({
            backdrop: "static"
        });
    });

    $(document).on("click", ".delete_btn", function () {
        //1、弹出是否确认删除对话框
        let empName = $(this).parents("tr").find("td:eq(2)").text();
        let empId = $(this).attr("delete-id");
        if (confirm("确认删除【" + empName + "】吗")) {
            //确认，发送ajax请求
            $.ajax({
                url: "${ctp}/emp/" + empId,
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);
                    toPage(currentPage);
                }
            });

        }
    })

    function getEmp(id) {
        $.ajax({
            url: "${ctp}/emp/" + id,
            type: "GET",
            async: false,
            success: function (result) {
                //console.log(result);
                let empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);
                $("#emp_update_btn").attr("edit-id", id);
            }
        });
    }

    $("#emp_update_btn").click(function () {
        let email = $("#email_update_input").val();
        let regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            //alert("邮箱格式不正确");
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确")
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "")
        }

        $.ajax({
            url: "${ctp}/emp/" + $(this).attr("edit-id"),
            type: "PUT",
            data: $("#empUpdateModal form").serialize(),
            success: function (result) {
                //alert(result.msg);
                //1、关闭对话框，回到本页面
                $("#empUpdateModal").modal("hide");
                //2、回到本页面
                toPage(currentPage);
            }

        });

    });

    $("#checkAll").click(function () {
        //alert($(this).prop("checked"));
        $(".check_item").prop("checked", $(this).prop("checked"));
    });

    $(document).on("click", ".check_item", function () {
        //判断当前选中的元素是否5个
        let flag = $(".check_item:checked").length === $(".check_item").length;
        $("#checkAll").prop("checked", flag);
    });

    //点击全部删除，批量删除
    $("#emp_delete_all_btn").click(function () {
        let empNames = "";
        let del_idstr = "";
        $.each($(".check_item:checked"), function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
            del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });
        if (empNames.length === 0) {
            confirm("请选择要删除的人");
        } else {
            empNames.substring(0, empNames.length - 1);
            del_idstr.substring(0, empNames.length - 1);
            if (confirm("确认删除【" + empNames + "】吗")) {
                //发送ajax请求删除
                $.ajax({
                    url: "${ctp}/emp/"+del_idstr,
                    type: "DELETE",
                    success: function (result) {
                        alert(result.msg);
                        toPage(currentPage);
                    }
                });
            }
        }
    });

</script>
</body>
</html>
