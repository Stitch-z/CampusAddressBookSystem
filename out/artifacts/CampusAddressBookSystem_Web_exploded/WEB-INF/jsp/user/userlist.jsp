<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css">
    <title>管理账户界面</title>

</head>
<body>
<%-- 引入公共界面布局 --%>
<%@include file="../common.jsp"%>
<div class="layui-body">
    <%-- 用于获取添加好友时的提示信息 --%>
    <input type="hidden" id="addLiaisonCheckMsg" name="addLiaisonCheckMsg" value="${addLiaisonCheckMsg}">
    <input type="hidden" id="addAccountMsg" name="addAccountMsg" value="${addAccountMsg}">
    <input type="hidden" id="deleteAccountMsg" name="deleteAccountMsg" value="${deleteAccountMsg}">
    <input type="hidden" id="becomeAdmin" name="becomeAdmin" value="${becomeAdmin}">

    <c:choose>
        <c:when test="${not empty userList}">
        <form id="form1" name="form1" method="post" action="">

            <!--container表示容器，所有内容放进这个容器-->
            <div class="container" style="padding: 80px;">
                <!-- row表示 一行的宽度 -->
                <div class="row">
                    <!--col-md-4 表示使用一行的4/12宽度 -->
                    <div class="col-md-4" >
                        <h1>所有${flag}账户</h1>
                    </div>
                </div>
                <hr/>
                <div class="row" style="float:left;display:flex;width:100%;margin-top: 35px;margin-bottom: 8px;">
                    <div class="input-group" style="margin-left: 12px">
                        <%-- 这个是为了在js中获取到--%>
                        <input id="laccount" type="hidden" value="${account}">
                        <input id="lrole" type="hidden" value="${lrole}">

    <%--                    <input id="key" type="text" class="form-control" style="width: 250px" placeholder="输入姓名或者电话号码关键字">
                        <span class="input-group-btn"><a class="btn btn-default" onclick="selectByKey(this)">查询</a></span>--%>
                    </div>


                    <div class="col-md-4 col-md-offset-9" >
                        <%--  添加模态框按钮--%>
                        <button class="btn btn-success" type="button" data-toggle="modal" data-target="#addModal" ><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> 创建账户</button>
                        <%--<button class="btn btn-danger" type="submit"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span> 批量删除</button>--%>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-11">
                        <table class="table table-hover">
                            <tr >
                                <th>账号</th>
                                <th>姓名</th>
                                <th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;手机</th>
                                <th>权限</th>
                                <th></th>
                            </tr>
                            <c:forEach items="${userList}" var="user">
                                <tr>
                                    <td>${user.uaccount}</td>
                                    <td>${user.uname}</td>
                                    <td>${user.uphone}</td>
                                    <td>${user.urole}</td>
                                    <td>
                                        <a class="btn btn-danger" href="deleteAccount?account=${user.uaccount}&flag=${flag}">
                                            <span class="glyphicon glyphicon-trash" aria-hidden="true"></span> 删除账号
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </div>
            </div>
        </form>
        </c:when>
        <c:otherwise>
            <div class="container" style="padding-left: 50px;padding-top: 10%;padding-right: 110px">
                <div class="jumbotron" style="width: 970px;height: 470px;">
                    <div style="text-align: center;margin-top: 10%;">
                        <h1 style="">还没有${urole}账号哦！！！</h1><br><br><br>
                        <button class="btn btn-success btn-lg" type="button" data-toggle="modal" data-target="#addModal"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> 创建账号</button>
                    </div>

                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- 添加模态框 -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <form action="addAccount">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h3 class="modal-title" id="myModalLabel2">添加账户</h3>
                </div>

                <div class="modal-body">
                    <div class="form-group">
                        <label class="control-label">帐号：</label>
                        <input type="text" name="uaccount" class="form-control"></input>
                    </div>

                    <div class="form-group">
                        <label class="control-label">密码：</label>
                        <input type="password" name="upwd" class="form-control"></input>
                    </div>

                    <div class="form-group">
                        <label class="control-label">确认密码：</label>
                        <input type="password" name="confirmUpwd" class="form-control"></input>
                    </div>

                    <div class="form-group">
                        <label class="control-label">姓名：</label>
                        <input type="text" name="uname" class="form-control"></input>
                    </div>
                    <div class="form-group">
                        <label class="control-label">性别：</label>
                        <input type="text" name="usex" class="form-control"></input>
                    </div>

                    <div class="form-group">
                        <label class="control-label">手机：</label>
                        <input type="text" name="uphone" class="form-control"></input>
                    </div>

                    <div class="form-group">
                        <label class="control-label">身份：</label>
                        <input readonly name="urole" value="${flag}" class="form-control"></input>
                    </div>


                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">保存</button>
                </div>
            </div>
        </form>
    </div>
</div>

</body>
</html>


<%--由于模态框script放前面无法生效，所以放在了后面--%>
<script>
    function selectByKey(a) {
        var key = $('#key').val();
        var laccount = $('#laccount').val();
        var lrole = $('#lrole').val();
        a.href="toselectliaisonlist?laccount=" + laccount + "&lrole=" + lrole + "&key=" + key;
    }

    $('#addModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget) // Button that triggered the modal
        var modal = $(this)
/*        modal.find('#laccount3').val(button.data('laccount'));
        modal.find('#lrole3').val(button.data('lrole'));*/
    })


    //页面一加载就执行该函数，弹出对话框
    window.onload = function check() {becomeAdmin
        var becomeAdmin = $('#becomeAdmin').val();
        var addLiaisonCheckMsg = $('#addLiaisonCheckMsg').val();
        var addAccountMsg = $('#addAccountMsg').val();
        var deleteAccountMsg = $('#deleteAccountMsg').val();
        if(addLiaisonCheckMsg!=''&&addLiaisonCheckMsg!=null){
            alert(addLiaisonCheckMsg);
            //blackMsg置为空，就不会加载重复弹出
            $('#addLiaisonCheckMsg').attr("value","");
        }
        else if(addAccountMsg!=''&&addAccountMsg!=null){
            alert(addAccountMsg);
            //blackMsg置为空，就不会加载重复弹出
            $('#addAccountMsg').attr("value","");
        }
        else if(deleteAccountMsg!=''&&deleteAccountMsg!=null){
            alert(deleteAccountMsg);
            //blackMsg置为空，就不会加载重复弹出
            $('#deleteAccountMsg').attr("value","");
        }
        else if(becomeAdmin!=''&&becomeAdmin!=null){
            alert(becomeAdmin);
            //blackMsg置为空，就不会加载重复弹出
            $('#becomeAdmin').attr("value","");
        }
        else {
            return;
        }
    }

</script>