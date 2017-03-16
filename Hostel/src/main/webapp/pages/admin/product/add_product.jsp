<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新增产品 - 产品管理 - 管理后台 - 哆哆甜品屋</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery-2.1.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</head>
<body class="admin-body">

<%@include file="../../common/admin_navbar.jsp"%>
<div class="wrapper">
    <div class="content">
        <div class="admin-panel">
            <h3 class="title">新增产品</h3>
            <div class="normal-div">店面名称： ${shop.name}</div>
            <label for="js-name-input" class="normal-input-label">产品名称</label>
            <input type="text" class="normal-input" id="js-name-input" />
            <label for="js-desc-textarea" class="normal-input-label">产品描述</label>
            <textarea class="normal-textarea" id="js-desc-textarea" rows=5></textarea>
            <div class="normal-div">产品图片</div>
            <div class="normal-div">
                <img src="" class="product-img"/>
                <input id="js-img-input" type="file" hidden onchange="imgChange()"/>
                <button class="button btn-submit btn-choose-img"
                    onclick="document.getElementById('js-img-input').click()">
                    选择图片</button>
            </div>
            <div class="button-group right-floated">
                <button class="button btn-cancel"
                        onclick="window.location.href='/admin/product'">返回</button>
                <button class="button btn-submit" onclick="submit()">提交</button>
            </div>
            <div class="clear-fix"></div>
        </div>
    </div>
</div>
<%@include file="/pages/common/toaster.jsp"%>
</body>

<style>
    .admin-panel {
        width: 400px;
    }
    .product-img {
        width: 160px;
        height: 160px;
    }
    .btn-choose-img {
        position: relative;
        bottom: 10px;
        left: 5px;
    }
</style>
<script>
    $(document).ready(function() {

    });

    function imgChange() {
        var icon = document.getElementById('js-img-input').files[0];
        $(".product-img").attr("src", window.URL.createObjectURL(icon));
    }

    function submit() {
        var data = new FormData();
        data.append("name", $("#js-name-input").val());
        data.append("description", $("#js-desc-textarea").val());
        data.append("img", document.getElementById("js-img-input").files[0]);

        $.ajax({
            type: "POST",
            url: "/admin/product/add",
            data: data,
            processData: false,
            contentType: false,
            success: function(data) {
                if (data["success"] == false) {
                    toaster(data["error"], "error");
                } else {
                    toaster("新增成功~", "success");
                    setTimeout(function () {
                        window.location.href = "/admin/product";
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
