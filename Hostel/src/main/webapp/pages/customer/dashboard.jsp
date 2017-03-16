<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的首页 - HOSTEL</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery-2.1.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</head>
<body>
<%@include file="../common/navbar.jsp" %>
<%@include file="../common/dashboard_header.jsp" %>
<div class="wrapper">
    <div class="content">
        <%@include file="../common/dashboard_left.jsp" %>
        <div class="right-content">
            <h3 class="title">我的账户</h3>

            <div class="normal-div">我的会员卡号：
                <span class="number">${info.vid}</span>

                <c:choose>
                    <c:when test="${info.state == 'invalid'}">
                        <span class="number">[未激活]</span>
                        <button class="button" onclick="window.location.href='/validate'">立即激活</button>
                    </c:when>
                    <c:when test="${info.state == 'valid'}">
                        <span class="number">[有效]</span>
                        <button class="button" onclick="stop()">停止账户</button>
                    </c:when>
                    <c:when test="${info.state == 'pause'}">
                        <span class="number">[已暂停]</span>
                        <button class="button" onclick="window.location.href='/user/recharge'">恢复使用</button>
                        <button class="button" onclick="stop()">停止账户</button>
                    </c:when>
                    <c:when test="${info.state == 'stop'}">
                        <span class="number">[已停止]</span>
                    </c:when>
                </c:choose>
            </div>

            <c:if test="${info.state == 'valid'}">
                <div class="normal-div">
                    我的会员级别： <span class="number">${info.level.level}</span>
                    享受优惠： <span class="number">${info.level.discount*10}</span> 折
                </div>
            </c:if>

            <div class="normal-div">我的账户余额：
                <span class="number">${info.level.balance}
                <button class="button" onclick="window.location.href='/user/recharge'">立即充值</button>
                </span>
            </div>
            <div class="normal-div">我的积分剩余：
                <span class="number">${info.level.point}
                    <button class="button" onclick="window.location.href='/user/point'">积分兑换</button>
                </span>
            </div>

            <div class="tips">
                <c:choose>
                    <c:when test="${info.state == 'invalid'}">
                        <div class="normal-div">您目前处于 <span class="number">未激活</span> 状态。
                            请立即激活您的账户。
                        </div>
                    </c:when>
                    <c:when test="${info.state == 'valid'}">
                        <div class="normal-div">您目前处于 <span class="number">有效</span> 状态。
                            如果到 <span class="number">
                                <fmt:formatDate value="${info.level.time}" pattern="yyyy-MM-dd"/>
                            </span> 时您的账户余额不足10元，您的账户将会变成 <span class="number">暂停</span> 状态。
                        </div>
                    </c:when>
                    <c:when test="${info.state == 'pause'}">
                        <div class="normal-div">您目前处于 <span class="number">暂停</span> 状态。
                            如果您不充值余额，您的账户将于 <span class="number">
                                <fmt:formatDate value="${info.level.time}" pattern="yyyy-MM-dd"/>
                            </span> 停止使用。
                        </div>
                    </c:when>
                </c:choose>
            </div>

        </div>
        <div class="clear-fix"></div>
    </div>


</div>

<%@include file="/pages/common/toaster.jsp" %>

</body>
<style>
    body {
        background-color: #f5f5f5;
    }

    .normal-div > .number {
        color: #d76863;
    }

    button {
        margin-left: 15px;
    }

    .tips {
        margin-top: 25px;
    }
</style>
<script>
    $(document).ready(function () {

    });
    function stop() {
        var flag = confirm("您是否真的要停止账户？（不可恢复）");
        if (flag == true) {
            $.ajax({
                type: "POST",
                url: "/user/stop",
                success: function (data) {
                    if (data["success"] == false) {
                        toaster(data["error"], "error");
                    } else {
                        toaster("停止成功~", "success");
                        setTimeout(function () {
                            window.location.href = "/dashboard";
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

