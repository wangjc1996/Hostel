<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>我的订单 - HOSTEL</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/datatables/datatables.css">
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
            <h3 class="title">我的订单</h3>

            <div class="table-container">
                <c:choose>
                    <c:when test="${list.size() == 0}">无订单</c:when>
                    <c:when test="${list.size() > 0}">
                        <table id="js-table" class="table table-striped table-bordered">
                            <thead>
                            <tr>
                                <th hidden>订单编号</th>
                                <th width="15%">酒店名称</th>
                                <th width="15%">入住日期</th>
                                <th width="15%">人员</th>
                                <th width="10%">房间</th>
                                <th width="15%">金额</th>
                                <th width="10%">入住</th>
                                <th width="10%">支付</th>
                                <th width="10%">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${list}" var="item">
                                <tr>
                                    <td hidden>${item.bookid}</td>
                                    <td>${item.hname}</td>
                                        <%--<td>${item.hid}</td>--%>
                                    <td>${item.date}</td>
                                    <td>${item.names}</td>
                                    <td>${item.type}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${item.price < 0}">${fn:substring(item.price, 1, 10)}</c:when>
                                            <c:when test="${item.price > 0}">${item.price}</c:when>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${item.checkin == 0}">未入住</c:when>
                                            <c:when test="${item.checkin > 0}">已入住</c:when>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${item.price > 0}">已支付</c:when>
                                            <c:when test="${item.price < 0}">待现金</c:when>
                                        </c:choose>
                                    </td>
                                    <td>
                                            <%--<button class="button" onclick="window.location.href--%>
                                            <%--='/user/order/detail?id=${item.id}'">详细</button>--%>
                                        <c:choose>
                                            <c:when test="${item.checkin == 0}">
                                                <button class="button" onclick="cancel(this)">取消</button>
                                            </c:when>
                                            <c:when test="${item.checkin > 0}">无</c:when>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                </c:choose>
            </div>

        </div>
    </div>
</div>

<%@include file="/pages/common/toaster.jsp" %>

</body>
<style>
    body {
        background-color: #f5f5f5;
    }
</style>
<script>
    $(document).ready(function () {

    });

    function cancel(obj) {
        var result = confirm("您是否真的要取消订单？");
        if (result) {
            $.ajax({
                type: "POST",
                url: "/user/order/cancel",
                data: {
                    planid: $(obj).parents("tr").children("td").eq(0).text()
                },
                success: function (data) {
                    if (data["success"] == false) {
                        toaster(data["error"], "error");
                    } else {
                        toaster("取消成功~", "success");
                        setTimeout(function () {
                            window.location.href = "/user/order";
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


