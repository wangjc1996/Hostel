<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>订单详情 - HOSTEL</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
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
            <span class="title">订单详情</span>
        </div>
    </div>
    <div class="content">
        <div class="register-panel">
            <div class="panel-content">
                <h3 class="title">订单详情</h3>
                <div class="clearfix"></div>
                <form class="register-form">
                    <div class="normal-div">房源号： ${book.planid}</div>
                    <div class="normal-div">会员卡号： ${book.vid}</div>
                    <div class="normal-div">酒店编号： ${book.hid}</div>
                    <div class="normal-div">酒店： ${book.hname}</div>
                    <div class="normal-div">入住人： ${book.names}</div>
                    <div class="normal-div">日期： ${book.date}</div>
                    <div class="normal-div">房型： ${book.type}</div>
                    <div class="normal-div">价格（折后）： ${book.price}</div>
                    <input class="normal-div input-password" type="password" name="password" placeholder="输入会员密码"/>
                    <button type="button" class="button btn-register right-floated" onclick="payVip()">会员卡支付</button>
                    <button type="button" class="button btn-register left-floated" onclick="noPay()">入住现金支付</button>
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

    function payVip() {
        var password = $(".input-password").val();

        $.ajax({
            type: "POST",
            url: "/pay/book",
            data: {
                planid: ${book.planid},
                names: '${book.names}',
                password: password,
            },
            success: function (data) {
                if (data["success"] == false) {
                    toaster(data["error"], "error");
                } else {
                    toaster("预定成功！马上自动跳转...", "success");
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

    function noPay() {
        //TODO
    }
</script>
</html>
