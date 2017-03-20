<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>非会员入住 - HOSTEL</title>
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
            <span class="title">非会员入住</span>
        </div>
    </div>
    <div class="content">
        <div class="register-panel">
            <div class="panel-content">
                <h3 class="title">非会员入住</h3>
                <div class="clearfix"></div>
                <form class="register-form">
                    <div class="normal-div">日期： ${plan.date}</div>
                    <div class="normal-div">房型： ${plan.type}</div>
                    <div class="normal-div">价格： ${plan.price}</div>
                    <input class="normal-div input-names" type="text" name="names" placeholder="入住人信息"/>
                    <button type="button" class="button btn-register right-floated" onclick="checkIn()">立即入住</button>
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

    function checkIn() {
        var names = $(".input-names").val();
        var flag = confirm("确认已支付现金并入住？");
        if (flag == true) {
            $.ajax({
                type: "POST",
                url: "/admin/hall/nonVipCheckin",
                data: {
                    planid: ${plan.planid},
                    names: names
                },
                success: function (data) {
                    if (data["success"] == false) {
                        toaster(data["error"], "error");
                    } else {
                        toaster("入住成功！马上自动跳转...", "success");
                        setTimeout(function () {
                            window.location.href = "/admin/hall";
                        }, 1000);
                    }
                },
                error: function () {
                    toaster("服务器出现问题，请稍微再试！", "error");
                }
            });
        }

    }

</script>
</html>
