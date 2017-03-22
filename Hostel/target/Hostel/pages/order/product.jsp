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
            <div class="search">
                <input class="input" id="js-date-input" type="text" placeholder="入住日期YYYY-MM-DD">
                <button class="btn-search" id="js-btn-search" onclick="getPlansByDate()">搜索</button>
            </div>
            <div class="clear-fix"></div>
            <c:choose>
                <c:when test="${planItems.size() == 0}">
                    <h1>无房源计划</h1>
                </c:when>
                <c:when test="${planItems.size() > 0}">
                    <div class="table-container">
                        <table id="js-table" class="table table-striped table-bordered">
                            <thead>
                            <tr>
                                <th width="18%">实景</th>
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
                                    <td>
                                        <img src="/assets/img/标准间.jpg" class="room-img">
                                            <%--<img src="/assets/img/大床房.jpg" class="room-img">--%>
                                            <%--<img src="/assets/img/套房.jpg" class="room-img">--%>
                                    </td>
                                    <td hidden>${item.planid}</td>
                                    <td>${item.date}</td>
                                    <td>${item.type}</td>
                                    <td>￥ ${item.price}</td>
                                    <td>${item.available}</td>
                                    <td>
                                        <input type="text" placeholder="入住人1" class="number-input"/>
                                        <br/>
                                        <input type="text" placeholder="入住人2" class="number-input"/>
                                    </td>
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
                </c:when>
            </c:choose>
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
            var planid = tds.eq(1).text();
            var name1 = tds.eq(6).children().eq(0).val();
            var name2 = tds.eq(6).children().eq(2).val();
            var names = name1 + name2;
            if (name1 != "" && name2 != "") {
                names = name1 + "-" + name2;
            }
            $.ajax({
                type: "POST",
                async: false,
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
                            async: false,
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
                                    setTimeout(function () {
                                        window.location.href = "/product/book?planid=" + planid + "&names=" + names;
                                    }, 1000);
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

    function getPlansByDate() {
        $.ajax({
            type: "GET",
            url: "/product/date",
            data: {
                hid:  ${product.hid},
                date: $("#js-date-input").val(),
            },
            success: function (data) {
                toaster("刷新成功！", "success");
                setTimeout(function () {
                    window.location.href = "/product/date?hid=" + ${product.hid} +"&date=" + $("#js-date-input").val();
                }, 1000);
            },
            error: function () {
                toaster("服务器出现问题，请稍微再试！", "error");
            }
        });
    }

</script>
</html>

