<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>会员登录 - HOSTEL</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery-2.1.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</head>
<body>
<div class="login">
    <div class="header">
        <div class="content">
            <a href="${pageContext.request.contextPath}/">
                <img src="${pageContext.request.contextPath}/assets/img/logo.png">
            </a>
            <span class="title">欢迎登录</span>
        </div>
    </div>
    <div class="content">
        <div class="login-panel">
            <div class="panel-content">
                <h3 class="title">会员登录</h3>
                <a href="${pageContext.request.contextPath}/register" class="right-floated register"><i
                        class="fa fa-sign-in"></i> 立即注册</a>
                <div class="clearfix"></div>
                <form class="login-form">
                    <input class="input-login" type="text" name="phone" placeholder="手机号"/>
                    <input class="input-password" type="password" name="password" placeholder="密码"/>
                    <input type="checkbox" id="js-checkbox-remember"/> 记住我
                    <button type="button" class="button btn-login right-floated" onclick="loginForm()">登录</button>
                    <div class="clear-fix"></div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
<%@include file="/pages/common/toaster.jsp" %>
<style>
    body {
        overflow-y: hidden;
        background-color: #f1f1f1;
    }
</style>
<script>
    $(document).ready(function () {
        fillForm();
    });

    function fillForm() {
        if (window.localStorage.getItem("remember") == 1) {
            $("#js-checkbox-remember").prop("checked", true);
            $(".input-login").val(window.localStorage.getItem("login"));
            $(".input-password").val(window.localStorage.getItem("password"));
        }
    }

    function loginForm() {
        if ($("#js-checkbox-remember").prop("checked") == true) {
            window.localStorage.setItem("remember", 1);
            window.localStorage.setItem("login", $(".input-login").val());
            window.localStorage.setItem("password", $(".input-password").val());
        } else {
            window.localStorage.setItem("remember", 0);
            window.localStorage.setItem("login", "");
            window.localStorage.setItem("password", "");
        }

        $.ajax({
            type: "POST",
            url: "/login",
            data: $('.login-form').serialize(),
            success: function (data) {
                if (data["success"] == false) {
                    toaster(data["error"], "error");
                    $(".input-password").val("");
                } else {
                    toaster("登录成功！马上自动跳转...", "success");
                    setTimeout(function () {
                        window.location.href = "/";
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
