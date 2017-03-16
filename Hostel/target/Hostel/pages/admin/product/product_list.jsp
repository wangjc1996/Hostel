<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>产品管理 - 管理后台 - 哆哆甜品屋</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/datatables/datatables.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery-2.1.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/datatables/datatables.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</head>
<body class="admin-body">
<%@include file="../../common/admin_navbar.jsp"%>
<div class="wrapper">
    <div class="content">
        <div class="admin-panel">
            <h3 class="title">产品管理
                <button class="button btn-submit right-floated"
                        onclick="window.location.href='/admin/product/add'">新增产品</button>
            </h3>

            <div class="normal-div">店面：
                ${shop.name}
            <div class="table-container">
                <table id="js-shop-table" class="table table-striped table-bordered">
                    <thead>
                    <tr>
                        <th width="10%">编号</th>
                        <th width="10%">图片</th>
                        <th width="30%">名称</th>
                        <th width="30%">描述</th>
                        <th width="20%">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${productSet}" var="item">
                        <tr class="product-item" productId="${item.id}">
                            <td>${item.id}</td>
                            <td><img class="product-icon" src="${item.img}" /></td>
                            <td>${item.name}</td>
                            <td>${item.description}</td>
                            <td>
                                <button class="button btn-submit" onclick="edit(this)">编辑</button>
                                <button class="button btn-cancel" onclick="deleteProduct(this)">删除</button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@include file="/pages/common/toaster.jsp"%>
</body>

<style>
    .product-icon {
        width: 30px;
        height: 30px;
    }
</style>
<script>
    $(document).ready(function() {
        loadTable();
    });
    function loadTable() {
        $("#js-shop-table").dataTable({
            "language": {
                url: '${pageContext.request.contextPath}/assets/plugins/datatables/Chinese.json'
            }
        });
    }
    function edit(obj) {
        var id = $(obj).parents(".product-item").attr("productId");
        window.location.href = "/admin/product/edit?id=" + id;
    }
    function deleteProduct(obj) {
        $.ajax({
            type: "POST",
            url: "/admin/product/delete",
            data: {
                id: $(obj).parents(".product-item").attr("productId")
            },
            success: function(data) {
                if (data["success"] == false) {
                    toaster(data["error"], "error");
                } else {
                    $(obj).parents(".product-item").remove();
                    toaster("删除成功~", "success");
                }
            },
            error: function() {
                toaster("服务器出现问题，请稍微再试！", "error");
            }
        });
    }
</script>
</html>
