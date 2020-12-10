<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人账户界面</title>
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css">

<%--    用jqury实现清空表单功能--%>
    <script type="text/javascript">
        function updateSuccess() {
            alert("个人信息修改成功！");
        }

        function formReset() {
            $("#uname").val("");
            $("#usex").val("");
            $("#urole").val("");
        }
    </script>
</head>
<body>
    <%--    引入公共界面布局--%>
    <%@include file="../common.jsp"%>
    <div class="layui-body">
            <!--container表示容器，所有内容放进这个容器-->
            <div class="container" style="padding: 80px;">
                <!-- row表示 一行的宽度-->
                <div class="row">
                    <!--col-md-4 表示使用一行的4/12宽度 -->
                    <div class="col-md-4" >
                        <h1>个人信息</h1>
                    </div>
                </div>
                <hr/>

                <form id="form1" class="form-horizontal" action="userupdate">
                    <div class="form-group" style="margin-top: 35px;">
                        <label for="uaccount" class="col-sm-2 control-label">账号</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="uaccount" name="uaccount" readonly="readonly" style="width: 350px" value="${user.uaccount}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="uname" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="uname" name="uname" style="width: 350px" value="${user.uname}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="usex" class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="usex" name="usex" style="width: 350px" value="${user.usex}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="urole" class="col-sm-2 control-label">身份</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="urole" name="urole" style="width: 350px" value="${user.urole}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="uphone" class="col-sm-2 control-label">手机</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="uphone" name="uphone" readonly="readonly" style="width: 350px" value="${user.uphone}">
                        </div>
                    </div>


                    &nbsp;
                    <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-10">
                            <button type="submit" class="btn btn-success" onclick="updateSuccess()">保存</button>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <button type="button" class="btn btn-info" onclick="formReset()">重置</button>
                        </div>
                    </div>
                </form>

            </div>
    </div>

</body>
</html>
<%--
<br>
<br>
<h3 style="color: black">个人账户信息</h3>
<form action="userupdate">
    <table border="1px" cellpadding="10px" cellspacing="3px"
           style="width: 30%;margin:auto;background:rgb(195,195,195)">
        <tr>
            <td>账号：</td>
            <td>${user.uaccount}</td>
        </tr>
        <tr>
            <td>姓名：</td>
            <td>${user.uname}</td>
        </tr>
        <tr>
            <td>电话：</td>
            <td>${user.uphone}</td>
        </tr>
        <tr>
            <td>地址：</td>
            <td>${user.uaddress}</td>
        </tr>
        <tr>
            <th colspan="2">
                <a href="tomain_user?uaccount=${uaccount}"><input  type="button" value="返回"  /></a>&nbsp;&nbsp;&nbsp;
                <a href="userpreupdate?uaccount=${user.uaccount}&upwd=${user.upwd}&uname=${user.uname}&uphone=${user.uphone}&uaddress=${user.uaddress}">
                    <input  type="button" value="修改" /></a>&nbsp;&nbsp;&nbsp;
                <a href="${pageContext.request.contextPath }/login.jsp"><input  type="button" value="注销" /></a>
            </th>
        </tr>
    </table>
</form>--%>
