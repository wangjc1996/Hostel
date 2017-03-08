<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header class="navbar">
    <div class="content">
        <div class="left-floated left-items">
            <div class="selected" id="js-navbar-shop-select"></div>
            <div class="select-panel" id="js-shop-panel">
                <ul></ul>
            </div>
        </div>
        <ul class="right-floated right-items">
            <li>
                <c:choose>
                    <c:when test="${sessionScope.get('id') == null}">
                        <a href="${pageContext.request.contextPath}/login" class="login">你好, 请登录</a>&nbsp;&nbsp
                        <a href="${pageContext.request.contextPath}/register" class="register">免费注册</a>
                    </c:when>
                    <c:otherwise>
                        ${sessionScope.get('name')}&nbsp;&nbsp;&nbsp;
                        <a href="${pageContext.request.contextPath}/logout">登出</a>
                    </c:otherwise>
                </c:choose>
            </li>
            <li class="spacer"></li>
            <li><a href="${pageContext.request.contextPath}/shoppingCart"><i class="fa fa-shopping-cart"></i> 购物车</a></li>
            <li class="spacer"></li>
            <li><a href="${pageContext.request.contextPath}/user/order">我的订单</a></li>
            <li class="spacer"></li>
            <li><a href="${pageContext.request.contextPath}/dashboard">我的哆哆</a></li>
            <c:if test="${sessionScope.get('role') != 5}">
                <li class="spacer"></li>
                <c:choose>
                    <c:when test="${sessionScope.get('id') == null}">
                        <li><a href="${pageContext.request.contextPath}/admin/login">后台登入</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="${pageContext.request.contextPath}/admin">返回后台</a></li>
                    </c:otherwise>
                </c:choose>
            </c:if>
        </ul>
        <div class="clearfix"></div>
    </div>
</header>
