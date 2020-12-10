<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <style type="text/css">
        *{margin:0;padding: 0;}
        body{background: #444;}
        .registerBox{width:420px;padding:0 20px;border:1px solid #fff; color:#000; margin-top:40px; border-radius:8px;background: white;box-shadow:0 0 15px #222; background: -moz-linear-gradient(top, #fff, #efefef 8%);background: -webkit-gradient(linear, 0 0, 0 100%, from(#f6f6f6), to(#f4f4f4));position: absolute;left:50%;top:50%;margin-left:-210px;margin-top:-165px;}
        .registerBox h2{height:45px;font-size:20px;font-weight:normal;}
        .registerBox .left{border-right:1px solid #ccc;height:100%;padding-right: 20px; }
    </style>

    <script type="text/javascript">
        function f() {
            var fail = document.getElementById("fail").text;
            if (fail!=null || fail!="") {
                $("#fail").css('display','none');
            }
        }

    </script>

<title>注册界面</title>
</head>
<body>

    <c:if test="${fail!=null}">
        <div class="alert alert-danger" role="alert" style="display: block; width: 320px;
            height: 50px; position: absolute; left: 480px; top: 70px" id="fail">${fail}</div>
    </c:if>

    <div class="container">
    
        <div class="registerBox row">
        
            <h2 class="text-center">用户注册</h2>
            <form class="form-horizontal" action="register">
                <div class="form-group">
                    <label class="col-sm-3 col-md-3 control-label">账号</label>
                    <div class="col-sm-8 col-md-8">
                        <input type="text" name="account" class="form-control" placeholder="输入账号" onclick="f()">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 col-md-3 control-label">姓名</label>
                    <div class="col-sm-8 col-md-8">
                        <input type="text" name="uname" class="form-control" placeholder="输入真实姓名" onclick="f()">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 col-md-3 control-label">手机</label>
                    <div class="col-sm-8 col-md-8">
                        <input type="text" name="phone" class="form-control" placeholder="输入11位数字的手机号码" onclick="f()">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 col-md-3 control-label">密码</label>
                    <div class="col-sm-8 col-md-8">
                        <input type="password" name="pwd" class="form-control" placeholder="输入密码" onclick="f()">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 col-md-3 control-label">确认密码</label>
                    <div class="col-sm-8 col-md-8">
                        <input type="password" name="confirmPwd" class="form-control" placeholder="再次确认密码" onclick="f()">
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-3 col-md-3 control-label">身份</label>
                    <label class="checkbox-inline">
                        <input type="radio" name="role" value="学生" checked> 学生
                    </label>
                    <label class="checkbox-inline">
                        <input type="radio" name="role" value="教师"> 教师
                    </label>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-4 col-sm-10 col-md-10">
                        <a href="${pageContext.request.contextPath }/login.jsp"><button type="button" class="btn btn-warning">返回</button></a>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <button type="submit" class="btn btn-success">注册</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>
</html>