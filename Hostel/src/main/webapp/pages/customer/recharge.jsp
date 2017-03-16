<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>立即充值 - HOSTEL</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery-2.1.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</head>
<body>
<%@include file="../common/navbar.jsp"%>
<%@include file="../common/dashboard_header.jsp"%>
<div class="wrapper">
    <div class="content">
        <%@include file="../common/dashboard_left.jsp"%>
        <div class="right-content">
            <h3 class="title">立即充值</h3>

            <div class="normal-div" style="margin-bottom: 20px;">目前余额：
                <span class="number" id="point-span">${info.level.balance}</span>
            </div>

            <div id="input-div">
                <label for="js-money-input" class="normal-input-label">充值金额（至少100元，整数）</label>
                <input type="number" id="js-money-input" class="normal-input">
                <label for="js-password-input" class="normal-input-label">请输入银行卡密码</label>
                <input type="password" id="js-password-input" class="normal-input">
                <button class="button btn-normal right-floated" onclick="submit()">提交</button>
                <div class="clear-fix"></div>
            </div>

            <div id="tips">
                <div class="normal-div">· 一次性充值1000元，升级为 普通会员</div>
                <div class="normal-div">· 一次性充值3000元，升级为 白银会员</div>
                <div class="normal-div">· 一次性充值5000元，升级为 黄金会员</div>
            </div>


        </div>
    </div>
</div>

<%@include file="/pages/common/toaster.jsp"%>

</body>
<style>
    body {
        background-color: #f5f5f5;
    }
    .normal-div > .number {
        color: #d76863;
    }
    #input-div {
        width: 300px;
    }
    #tips {
        margin-top: 20px;
        font-size: 13px;
    }
</style>
<script>
    $(document).ready(function() {

    });
    function submit() {
        $.ajax({
            type: "POST",
            url: "/user/recharge",
            data: {
                money: $("#js-money-input").val(),
                password: $("#js-password-input").val()
            },
            success: function(data) {
                if (data["success"] == false) {
                    toaster(data["error"], "error");
                } else {
                    toaster("充值成功~", "success");
                    setTimeout(function () {
                        window.location.href = "/user/recharge";
                    }, 1000);
                }
            },
            error: function() {
                toaster("服务器出现问题，请稍微再试！", "error");
            }
        });
    }
</script>
</html>

