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
<title>课程界面</title>

</head>
<body>
    <%--    引入公共界面布局--%>
    <%@include file="../common.jsp"%>

    <div id="div1" name="div1" class="layui-body">
        <%-- 这个是为了在js中获取到--%>
        <input id="account" type="hidden" value="${account}">
        <input id="role" type="hidden" value="${role}">
        <input id="flag" type="hidden" value="${flag}">

        <%-- 用于获取申请加入课程和退出课程时的提示信息 --%>
        <input type="hidden" id="applyCourse" name="applyCourse" value="${applyCourse}">
        <input type="hidden" id="addLiaisonCheckMsg" name="addLiaisonCheckMsg" value="${addLiaisonCheckMsg}">
    <c:choose>
        <c:when test="${not empty courseList}">
            <form id="form1" name="form1" method="post" action="">
                <!--container表示容器，所有内容放进这个容器-->
                <div class="container" style="padding: 80px;">
                    <!-- row表示 一行的宽度-->
                    <div class="row">
                        <!--col-md-4 表示使用一行的4/12宽度 -->
                        <div class="col-md-4" >
                            <c:choose>
                                <c:when test="${flag=='all' and role!='管理员'}">
                                    <h1>所有课程</h1>
                                </c:when>
                                <c:when test="${flag=='all' and role=='管理员'}">
                                    <h1>管理所有课程</h1>
                                </c:when>
                                <c:when test="${flag=='selected'}">
                                    <h1>已选课程</h1>
                                </c:when>
                                <c:when test="${flag=='notSelected'}">
                                    <h1>未选课程</h1>
                                </c:when>
                                <c:when test="${flag=='teach'}">
                                    <h1>所教课程</h1>
                                </c:when>
                            </c:choose>

                        </div>
                    </div>
                    <hr/>
                    <div class="row" style="float:left;display:flex;width:100%;margin-top: 35px;margin-bottom: 8px;">
                        <div class="input-group" style="margin-left: 12px">

                            <input id="key" type="text" class="form-control" style="width: 250px" placeholder="输入课程名称关键字">
                            <span class="input-group-btn"><a class="btn btn-default" onclick="selectByKey(this)">查询</a></span>
                        </div>

                        <div class="col-md-4 col-md-offset-5" >
                            <c:if test="${role=='教师'}">
                                <button class="btn btn-success" type="button" data-toggle="modal" data-target="#addModal"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> 创建课程</button>
                            </c:if>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-11">
                            <table class="table table-hover">
                                <tr >
                                    <th>课程编号</th>
                                    <th>课程名称</th>
                                    <c:if test="${role=='学生' or role=='管理员' or flag=='all'}">
                                        <th>课程教师</th>
                                    </c:if>
                                    <th></th>
                                </tr>
                                <c:forEach items="${courseList}" var="course">
                                    <tr>
                                        <td>${course.caccount}</td>
                                        <td>${course.cname}</td>
                                        <c:if test="${role=='学生' or role=='管理员' or flag=='all'}">
                                            <td>${course.cteacher}</td>
                                        </c:if>

                                        <td>

                                            <c:if test="${role=='学生'}">
                                                <c:if test="${flag=='all'}">
                                                    <a class="btn btn-info" href="addTeacher?laccount=${account}&lnumber=${course.taccount}"> <span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span> 添加老师至通讯录</a>
                                                </c:if>
                                                <c:if test="${flag=='selected'}">
                                                    <a class="btn btn-info" href="lookCourseLiaisonlist?caccount=${course.caccount}&cname=${course.cname}&account=${account}"> <span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span> 查看课程成员</a>
                                                    <a class="btn btn-danger" href="sendNotify?nfrom=${account}&nto=${course.taccount}&ntoName=${course.cteacher}&ncourse=${course.caccount}&ncontent=申请退出课程《${course.cname}》&nstate=未审核&ntype=消息&flag=selected">
                                                        <span class="glyphicon glyphicon-ban-circle" aria-hidden="true"></span> 退选
                                                    </a>
                                                </c:if>

                                                <c:if test="${flag=='notSelected'}">
                                                    <a class="btn btn-info" href="sendNotify?nfrom=${account}&nto=${course.taccount}&ntoName=${course.cteacher}&ncourse=${course.caccount}&ncontent=申请加入课程《${course.cname}》&nstate=未审核&ntype=消息&flag=notSelected"> <span class="glyphicon glyphicon-plus" aria-hidden="true"></span> 加入课程</a>
                                                </c:if>
                                            </c:if>

                                            <c:if test="${role=='教师' and flag!='all'}">
                                                <a class="btn btn-info" href="lookCourseLiaisonlist?caccount=${course.caccount}&cname=${course.cname}&account=${account}"> <span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span> 查看课程成员</a>
                                                <a class="btn btn-danger" href="sendCourseNotify?nfrom=${account}&ntoRole=管理员&ncourse=${course.caccount}&ncontent=申请结束课程《${course.cname}》&nstate=未审核&ntype=消息"> <span class="glyphicon glyphicon-ban-circle" aria-hidden="true"></span> 结束课程</a>
                                                <%--                                            <a class="btn btn-info" href=""> <span class="glyphicon glyphicon-plus" aria-hidden="true"></span> 加入课程</a>--%>
                                            </c:if>

                                            <c:if test="${role=='教师' and flag=='all' and course.cteacher!=name}">
                                                <a class="btn btn-info" href="addTeacher?laccount=${account}&lnumber=${course.taccount}"> <span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span> 添加同事至通讯录</a>
                                            </c:if>

                                            <c:if test="${role=='管理员'}">

                                                <a class="btn btn-info" href="lookCourseLiaisonlist?caccount=${course.caccount}&cname=${course.cname}&account=${account}"> <span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span> 查看课程成员</a>
                                                <a class="btn btn-danger" href="deleteCourse?caccount=${course.caccount}&flag=all"> <span class="glyphicon glyphicon-ban-circle" aria-hidden="true"></span> 注销课程</a>
                                                <%--                                            <a class="btn btn-info" href=""> <span class="glyphicon glyphicon-plus" aria-hidden="true"></span> 加入课程</a>--%>
                                            </c:if>

                                        </td>

                                    </tr>
                                </c:forEach>
                            </table>
                        </div>
                    </div>
                </div>
            </form>
        </c:when>
        <c:when test="${role=='教师'}">
            <div class="container" style="padding-left: 50px;padding-top: 10%;padding-right: 110px">
                <div class="jumbotron" style="width: 970px;height: 470px;">
                    <div style="text-align: center;margin-top: 10%;">
                        <h1 style="">还没有课程哦！！！</h1><br><br><br>
                        <button class="btn btn-success btn-lg" type="button" data-toggle="modal" data-target="#addModal"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> 创建课程</button>
                    </div>

                </div>
            </div>
        </c:when>
        <c:when test="${role=='学生' or role=='管理员'}">
            <div class="container" style="padding-left: 50px;padding-top: 10%;padding-right: 110px">
                <div class="jumbotron" style="width: 970px;height: 470px;">
                    <div style="text-align: center;margin-top: 10%;">
                        <h1 style="">还没有课程哦！！！</h1><br><br><br>
                    </div>

                </div>
            </div>
        </c:when>
    </c:choose>
    </div>

    <!-- 添加模态框 -->
    <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <form action="addCourse">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h3 class="modal-title" id="myModalLabel2">创建课程</h3>
                    </div>

                    <div class="modal-body">

                        <div class="form-group">
                            <label class="control-label">教师编号：</label>
                            <input readonly name="taccount" value="${account}" class="form-control"></input>
                        </div>
                        <div class="form-group">
                            <label class="control-label">教师姓名：</label>
                            <input readonly name="cteacher" value="${name}" class="form-control"></input>
                        </div>

                        <div class="form-group">
                            <label class="control-label">课程编号：</label>
                            <input type="text" name="caccount" class="form-control"></input>
                        </div>

                        <div class="form-group">
                            <label class="control-label">课程名称：</label>
                            <input type="text" name="cname" class="form-control"></input>
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

<script>

    function selectByKey(a) {
        var key = $('#key').val();
        var account = $('#account').val();
        var role = $('#role').val();
        var flag = $('#flag').val();
        a.href="toSelectCourselist?" + "account=" + account + "&role=" + role + "&key=" + key + "&flag=" + flag;
    }

    $('#addModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget) // Button that triggered the modal
        var modal = $(this)
        /*        modal.find('#laccount3').val(button.data('laccount'));
                modal.find('#lrole3').val(button.data('lrole'));*/
    })

    //页面一加载就执行该函数，弹出对话框
    window.onload = function check() {
        var applyCourse = $('#applyCourse').val();
        var addLiaisonCheckMsg = $('#addLiaisonCheckMsg').val();
        if(applyCourse!=''&&applyCourse!=null){
            alert(applyCourse);
            //blackMsg置为空，就不会加载重复弹出
            $('#applyCourse').attr("value","");
            return;
        }
        else if(addLiaisonCheckMsg!=''&&addLiaisonCheckMsg!=null){
            alert(addLiaisonCheckMsg);
            //blackMsg置为空，就不会加载重复弹出
            $('#addLiaisonCheckMsg').attr("value","");
        }
        else {
            return;
        }
    }

</script>