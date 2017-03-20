<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header class="navbar">
    <div class="content">
        <ul class="right-floated right-items">
            <li>
                <c:choose>
                    <c:when test="${sessionScope.get('vip_vid') == null}">
                        <a href="${pageContext.request.contextPath}/login" class="login">你好, 请登录</a>&nbsp;&nbsp
                        <a href="${pageContext.request.contextPath}/register" class="register">免费注册</a>
                    </c:when>
                    <c:otherwise>
                        ${sessionScope.get('vip_name')}&nbsp;&nbsp;&nbsp;
                        <a href="${pageContext.request.contextPath}/logout">登出</a>
                    </c:otherwise>
                </c:choose>
            </li>
            <li class="spacer"></li>
            <li><a href="${pageContext.request.contextPath}/dashboard">我的账户</a></li>
            <c:if test="${sessionScope.get('role') != 5}">
                <li class="spacer"></li>
                <c:choose>
                    <c:when test="${sessionScope.get('hid') == null}">
                        <li><a href="${pageContext.request.contextPath}/admin/login">后台登入</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="${pageContext.request.contextPath}/admin/plan">返回后台</a></li>
                    </c:otherwise>
                </c:choose>
            </c:if>
        </ul>
        <div class="clearfix"></div>
    </div>
</header>
