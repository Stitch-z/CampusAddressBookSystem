<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改密码界面</title>
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css">

    <script type="text/javascript">

        //清除表单
        function formReset() {
            $("#pwd").val("");
            $("#oldPwd").val("");
            $("#newPwd").val("");
            $("#confirmPwd").val("");
        }

        //把弹出框隐藏
        function f() {
            var pwdMsg = document.getElementById("pwdMsg").text;
            if (pwdMsg!=null || pwdMsg!="") {
                $("#pwdMsg").css('display','none');
            }
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
                        <h1>修改密码</h1>
                    </div>
                </div>
                <hr/>
                <c:if test="${pwdMsg!=null}">
                    <div class="alert alert-danger" role="alert" style="display: block; width: 320px;
            height: 45px; position: absolute; left: 270px; top: 145px" id="pwdMsg">${pwdMsg}</div>
                </c:if>

                <form id="form1" class="form-horizontal" action="updatePwd">

                    <input type="hidden" class="form-control" id="uaccount" name="uaccount" value="${account}">
                    <input type="hidden" class="form-control" id="pwd" name="pwd" value="${pwd}">

                    <div class="form-group" style="margin-top: 70px;">
                        <label for="oldPwd" class="col-sm-2 control-label">原密码</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="oldPwd" name="oldPwd" placeholder="输入原始密码" style="width: 350px" onclick="f()">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="newPwd" class="col-sm-2 control-label">新密码</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="newPwd" name="newPwd" placeholder="输入不少于8位数的字母或数字" style="width: 350px" onclick="f()">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="confirmPwd" class="col-sm-2 control-label">确认密码</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="confirmPwd" name="confirmPwd"style="width: 350px" placeholder="再次确认新密码" onclick="f()">
                        </div>
                    </div>

                    &nbsp;
                    <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-10">
                            <button type="submit" class="btn btn-success">修改</button>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <button type="button" class="btn btn-info" onclick="formReset()">重置</button>
                        </div>
                    </div>
                </form>

            </div>
    </div>

</body>
</html>
