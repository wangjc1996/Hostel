<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="dashboard-header">
    <div class="content">
        <a href="${pageContext.request.contextPath}/">
            <img src="${pageContext.request.contextPath}/assets/img/logo_w.png" class="logo">
        </a>
        <div class="shopping-cart">
            <button class="btn-cart" onclick="window.location.href='/shoppingCart'">
                <i class="fa fa-shopping-cart"></i> 购物车</button>
        </div>
    </div>
</div>