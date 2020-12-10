<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css">
<title>登录界面</title>

    <style type="text/css">
        *{margin:0;padding: 0;}
        body{background: #444;}
        .loginBox{width:420px;height:280px;padding:0 20px;border:1px solid #fff; color:#000; margin-top:40px; border-radius:8px;background: white;box-shadow:0 0 15px #222; background: -moz-linear-gradient(top, #fff, #efefef 8%);background: -webkit-gradient(linear, 0 0, 0 100%, from(#f6f6f6), to(#f4f4f4));position: absolute;left:50%;top:50%;margin-left:-210px;margin-top:-165px;}
        .loginBox h2{height:45px;font-size:20px;font-weight:normal;}
        .loginBox .left{border-right:1px solid #ccc;height:100%;padding-right: 20px; }

    </style>

	<script type="text/javascript">
		function f() {
			var msg = document.getElementById("msg").text;
			if (msg!=null || msg!="") {
				$("#msg").css('display','none');
			}
        }

	</script>

</head>
<body>
    <c:if test="${msg=='账号或密码错误，请重新输入！'}">
        <div class="alert alert-danger" role="alert" style="display: block; width: 320px;
        height: 50px; position: absolute; left: 480px; top: 70px" id="msg">${msg}</div>
    </c:if>
	<c:if test="${msg=='Please Login!'}">
		<div class="alert alert-danger" role="alert" style="display: block; width: 320px;
        height: 50px; position: absolute; left: 480px; top: 70px" id="msg">${msg}</div>
	</c:if>
    <c:if test="${msg=='注册成功！'}">
        <div class="alert alert-success" role="alert" style="display: block; width: 320px;
        height: 50px; position: absolute; left: 480px; top: 70px" id="msg">${msg}</div>
    </c:if>
	<c:if test="${msg=='密码修改成功，请重新登录！'}">
		<div class="alert alert-success" role="alert" style="display: block; width: 320px;
        height: 50px; position: absolute; left: 480px; top: 70px" id="msg">${msg}</div>
	</c:if>
    <div class="container">
        <div class="loginBox row">
            <h2 class="text-center">校园通讯录管理系统</h2>
		    <form class="form-horizontal" action="login" method="post">
		        <div class="form-group">
		            <label class="col-sm-3 col-md-3 control-label">账号</label>
		            <div class="col-sm-8 col-md-8">
		                <input type="text" class="form-control" name="account" placeholder="输入登录账号" onclick="f()">
		            </div>
		        </div>
		        <div class="form-group">
		            <label class="col-sm-3 col-md-3 control-label">密码</label>
		            <div class="col-sm-8 col-md-8">
		                <input type="password" class="form-control" name="pwd" placeholder="输入登录密码" onclick="f()">
		            </div>
		        </div>
		        <div class="form-group">
                    <div class="col-sm-offset-4 col-sm-10" style="color: #990033;"></div>
                </div>
		        <div class="form-group">
		            <div class="col-sm-offset-4 col-sm-10 col-md-10">
		                <button type="submit" class="btn btn-success">登录</button>
		                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		                <button type="button" class="btn btn-info"
		                    onclick="location.href='toregister'">注册</button>
		            </div>
		        </div>
		    </form>
        
        </div>
        
    </div>

</body>
</html>
