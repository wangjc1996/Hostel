<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>激活会员 - HOSTEL</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery-2.1.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</head>
<body>
<%@include file="../common/navbar.jsp"%>

<div class="wrapper">

    <div class="content">
        <div class="mid-panel validate-panel">
            <h3 class="title">激活会员资格</h3>
            <p class="tips">注意：请一次性充值1000元以上以激活会员资格。金额将从您的银行卡中扣取。</p>
            <div class="code-div">您的会员卡号： <span class="number">${info.vid}</span></div>
            <div>您的银行卡号： <span class="number">${bank.bankid}</span></div>
            <label for="js-money-input" class="normal-input-label">充值金额（>=1000元，整数）：</label>
            <input type="number" id="js-money-input" class="normal-input">
            <label for="js-password-input" class="normal-input-label">请输入银行卡密码</label>
            <input type="password" id="js-password-input" class="normal-input">
            <button class="button btn-submit right-floated" onclick="submit()">提交</button>
            <div class="clear-fix"></div>
        </div>
        <div id="tips">
            <div class="normal-div">· 一次性充值1000元，升级为 普通会员</div>
            <div class="normal-div">· 一次性充值3000元，升级为 白银会员</div>
            <div class="normal-div">· 一次性充值5000元，升级为 黄金会员</div>
        </div>
    </div>

</div>

<%@include file="/pages/common/toaster.jsp"%>

</body>
<style>
    body {
        background-color: #f5f5f5;
    }
    .wrapper > .content {
        width:450px;
        background-color: #fff;
    }
</style>
<script>
    $(document).ready(function() {

    });

    function submit() {
        $.ajax({
            type: "POST",
            url: "/validate",
            data: {
                money: $("#js-money-input").val(),
                password: $("#js-password-input").val()
            },
            success: function(data) {
                if (data["success"] == false) {
                    toaster(data["error"], "error");
                } else {
                    toaster("会员激活成功！马上跳转到首页...", "success");
                    setTimeout(function () {
                        window.location.href = "/";
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

