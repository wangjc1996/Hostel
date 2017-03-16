<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${product.name} - HOSTEL</title>
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
        <div class="product-container">
            <div class="product-intro">
                <img src="${product.imgPath}" class="product-img"/>
                <div class="intro">
                    <div class="normal-div">名称： ${product.name}</div>
                    <div class="normal-div">地址： ${product.location}</div>
                    <div class="normal-div">电话： ${product.phone}</div>
                </div>
                <div class="clear-fix"></div>
            </div>

            <div class="table-container">
                <table id="js-table" class="table table-striped table-bordered">
                    <thead>
                    <tr>
                        <th width="20%">日期</th>
                        <th width="15%">房型</th>
                        <th width="15%">单价</th>
                        <th width="15%">剩余数量</th>
                        <th width="15%">入住旅客</th>
                        <th width="20%">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${planItems}" var="item">
                        <tr>
                            <td hidden>${item.planid}</td>
                            <td>${item.date}</td>
                            <td>${item.type}</td>
                            <td>￥ ${item.price}</td>
                            <td>${item.available}</td>
                            <td><input type="text" placeholder="&分割"
                                       class="number-input"/></td>
                            <td>
                                <c:if test="${item.available > 0}">
                                    <button class="button button-book">立即预定</button>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
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

    .product-container {
        background-color: #fff;
        padding: 20px;
    }

    .product-img {
        float: left;
        width: 180px;
        height: 180px;
    }

    .intro {
        float: left;
        margin-left: 20px;
    }

    .number-input {
        width: 70px;
        outline: none;
    }
</style>
<script>
    $(document).ready(function () {
        initItem();
    });

        function initItem() {
            $(".button-book").click(function () {
                var tds = $(this).parents("tr").children();
                var planid = tds.eq(0).text();
                var names = tds.eq(5).children().eq(0).val();
                <%--if (name==null || name=="")--%>
                        <%--names = '<%=(String) session.getAttribute("vip_name") %>';--%>

                $.ajax({
                    type: "POST",
                    async:false,
                    url: "/product/check",
                    data: {
                        planid: planid,
                        names: names,
                    },
                    contentType: "application/x-www-form-urlencoded; charset=utf-8",
                    success: function (data) {
                        if (data["success"] == false) {
                            toaster(data["error"], "error");
                        } else {
                            $.ajax({
                                type: "GET",
                                async:false,
                                url: "/product/book",
                                data: {
                                    planid: planid,
                                    names: names,
                                },
                                success: function (data) {
                                    if (data["success"] == false) {
                                        toaster(data["error"], "error");
                                    } else {
                                        toaster("正在跳转至支付界面", "success");
                                        window.location.href = "/product/book?planid=" + planid + "&names=" + names;
                                    }
                                },
                                error: function () {
                                    toaster("服务器出现问题，请稍微再试！", "error");
                                }
                            });
                        }
                    },
                    error: function () {
                        toaster("服务器出现问题，请稍微再试！", "error");
                    }
                });

            });

    }
</script>
</html>

