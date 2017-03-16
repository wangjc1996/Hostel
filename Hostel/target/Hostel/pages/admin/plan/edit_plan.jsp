<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改计划 - HOSTEL</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/datatables/datatables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery-2.1.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</head>
<body>
<div class="register">
    <div class="header">
        <div class="content">
            <a href="${pageContext.request.contextPath}/">
                <img src="${pageContext.request.contextPath}/assets/img/logo.png">
            </a>
            <span class="title">修改计划</span>
        </div>
    </div>
    <div class="content">
        <div class="register-panel">
            <div class="panel-content">
                <h3 class="title">修改计划</h3>
                <div class="clearfix"></div>
                <form class="plan-form">
                    <div class="normal-div">计划号： ${plan.planid}
                        <input class="input-planid" type="number" name="planid" value="${plan.planid}" hidden/>
                    </div>
                    <div class="normal-div">酒店号：${plan.hid}
                        <input class="input-hid" type="number" name="hid" value="${plan.hid}" hidden/>
                    </div>
                    <div class="normal-div">日期：${plan.date}
                        <input class="input-date" type="text" name="date" value="${plan.date}" hidden/>
                    </div>
                    <div class="normal-div">房型：${plan.type}
                        <input class="input-type" type="text" name="type" value="${plan.type}" hidden>
                    </div>
                    <div class="normal-div">价格：
                        <input class="input-price" type="number" name="price" value="${plan.price}"/>
                    </div>
                    <div class="normal-div">剩余：
                        <input class="input-available" type="number" name="available" value="${plan.available}"/>
                    </div>
                    <button type="button" class="button btn-register right-floated" onclick="registerForm()">修改</button>
                    <div class="clear-fix"></div>
                </form>
            </div>
        </div>
    </div>
</div>
<%@include file="/pages/common/toaster.jsp" %>
</body>
<style>
    body {
        overflow-y: hidden;
        background-color: #f1f1f1;
    }
</style>
<script>
    $(document).ready(function () {

    });

    function registerForm() {
        $.ajax({
            type: "POST",
            url: "/admin/plan/edit",
            data: $('.plan-form').serialize(),
            success: function (data) {
                if (data["success"] == false) {
                    toaster(data["error"], "error");
                } else {
                    toaster("修改成功！马上自动跳转...", "success");
                    setTimeout(function () {
                        window.location.href = "/admin/plan";
                    }, 1000);
                }
            },
            error: function () {
                toaster("服务器出现问题，请稍微再试！", "error");
            }
        });
    }
</script>
</html>
