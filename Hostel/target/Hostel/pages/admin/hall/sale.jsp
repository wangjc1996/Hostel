<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>销售 - 管理后台 - 哆哆甜品屋</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/datatables/datatables.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery-2.1.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</head>
<body class="admin-body">

<%@include file="../../common/admin_navbar.jsp"%>
<div class="wrapper">
    <div class="content">
        <div class="admin-panel">
            <h3 class="title">销售</h3>
            <div>
                <div class="normal-div">门店： ${shop.name}</div>
            </div>
            <div style="margin: 20px 0 15px 0;">
                <a href="/admin/sale/order">已预订销售</a>
                <a href="/admin/sale/buy">未预订销售</a>
            </div>

            <div class="table-container">
                <table id="js-table" class="table table-striped table-bordered">
                    <thead>
                    <tr>
                        <th width="30%">产品</th>
                        <th width="25%">单价</th>
                        <th width="25%">剩余数量</th>
                        <th width="20%">购买数量</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${planItemList}" var="item">
                        <tr>
                            <td hidden>${item.product.id}</td>
                            <td>${item.product.name}</td>
                            <td>${item.price}</td>
                            <td>${item.remaining}</td>
                            <td><input type="number" min="0" max="${item.remaining}" value="0"
                                       class="number-input" onchange="changeTotal()"/></td>
                            <td hidden>${item.point}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="right-floated">
                <input id="code-input" class="normal-input" type="text" placeholder="请输入会员卡号"
                    onchange="getCustomer()">
                <div class="normal-div">会员级别： <span id="level-span">-</span></div>
                <div class="normal-div">卡余额： <span id="balance-span">-</span></div>
                <div class="normal-div">优惠折扣： <span id="discount-span">1</span></div>
                <div class="normal-div">原始价格： <span id="original-price-span">-</span></div>
                <div class="normal-div" style="margin-bottom: 20px;">折后价格： <span id="actual-price-span">-</span></div>
                <button class="button btn-submit" onclick="pay(1)">卡余额支付</button>
                <button class="button btn-cancel" onclick="pay(2)">现金支付</button>
            </div>
            <div class="clear-fix"></div>

        </div>
    </div>
</div>
<%@include file="/pages/common/toaster.jsp"%>
</body>

<style>
    #code-input {
        width: 250px;
    }
</style>
<script>
    var customer;

    $(document).ready(function() {

    });
    
    function changeTotal() {
        var total = 0;
        $("#js-table tbody").children("tr").each(function () {
            total += parseFloat($(this).children("td").eq(2).text()) *
                    parseInt($(this).children("td").eq(4).children("input").eq(0).val());
        });
        $("#original-price-span").text(total.toFixed(2));
        $("#actual-price-span").text((total*parseFloat($("#discount-span").text())).toFixed(2));
    }
    
    function getCustomer() {
        $.ajax({
            type: "POST",
            url: "/admin/customer",
            data: {
                code: $("#code-input").val()
            },
            success: function(data) {
                if (data["success"] == false) {
                    toaster(data["error"], "error");
                } else {
                    customer = data.customer;
                    $("#level-span").text(data.customer.customerAccount.vipLevel.name);
                    $("#balance-span").text(data.customer.customerAccount.balance);
                    $("#discount-span").text(data.customer.customerAccount.vipLevel.discount);
                    $("#actual-price-span").text($("#original-price-span").text() * $("#discount-span").text());
                }
            },
            error: function() {
                toaster("服务器出现问题，请稍微再试！", "error");
            }
        });
    }

    function pay(type) {

        if (type == 1 && parseFloat($("#balance-span").text()) <
                parseFloat($("#actual-price-span").text())) {
            toaster("卡余额不足，请用现金支付！", "error");
            return;
        }

        var object = {};
        object.type = type;
        object.customerId = customer.id;
        var items = [];
        $("#js-table tbody").children("tr").each(function () {
            var item = {};
            item.productId = $(this).children("td").eq(0).text();
            item.price = parseFloat($(this).children("td").eq(2).text());
            item.number = parseInt($(this).children("td").eq(4).children("input").eq(0).val());
            item.point = parseInt($(this).children("td").eq(5).text());
            if (item.number != 0) {
                items.push(item);
            }
        });
        object.items = items;
        console.log(object);

        $.ajax({
            type: "POST",
            url: "/admin/sale/pay",
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify(object),
            success: function(data) {
                if (data["success"] == false) {
                    toaster(data["error"], "error");
                } else {
                    toaster("支付成功~", "success");
                    setTimeout(function () {
                        window.location.href = "/admin/sale/buy";
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
