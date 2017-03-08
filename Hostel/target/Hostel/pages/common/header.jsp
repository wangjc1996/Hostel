<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="header">
    <div class="content">
        <a href="${pageContext.request.contextPath}/">
            <img src="${pageContext.request.contextPath}/assets/img/logo.png">
        </a>
        <div class="search">
            <input class="input" id="js-search-input" type="text" placeholder="搜索产品...">
            <button class="btn-search" id="js-btn-search">搜索</button>
        </div>
        <div class="shopping-cart">
            <button class="btn-cart" onclick="window.location.href='/shoppingCart'">
                <i class="fa fa-shopping-cart"></i> 购物车</button>
            <button class="btn-order" onclick="window.location.href='/user/order'">我的订单</button>
        </div>
    </div>
</div>