<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>首页 - HOSTEL</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery-2.1.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</head>
<body>
<%@include file="common/navbar.jsp" %>
<%@include file="common/header.jsp" %>

<div class="wrapper">

    <div class="content">
        <div class="product-panel" id="product-panel"></div>
    </div>

</div>
<script>
    $(document).ready(function () {
        getProducts(null);
        searchInit();
    });

    function getProducts(key) {
        $.ajax({
            type: "GET",
            url: "/getProducts",
            data: {
                key: key
            },
            success: function (data) {
                $("#product-panel").empty();
                var list = data.list;
                for (var i = 0; i < list.length; i++) {
                    var html =
                            '<div class="product-card" productId="' + list[i].hid + '">' +
                            '<img src="' + list[i].imgPath + '" class="product-img">' +
                            '<div class="product-price">' + list[i].name + '</div>' +
                            '<div class="product-name">' + list[i].location + '</div>' +
                            '<div class="product-phone">电话:' + list[i].phone + '</div>' +
                            '</div>';
                    $("#product-panel").append(html);
                }
                $("#product-panel").children(".product-card").click(function () {
                    window.location.href = "/product?hid=" + $(this).attr("productId");
                });


            },
            error: function () {
                toaster("服务器出现问题，请稍微再试！", "error");
            }
        });
    }

    function loadProducts() {
        getProducts(null);
        $("#js-search-input").val("");
    }

    function searchInit() {
        $("#js-btn-search").click(function () {
            getProducts($("#js-search-input").val());
        });
    }

</script>
</body>
</html>
