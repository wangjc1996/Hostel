package nju.adrien.interceptor;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor extends HandlerInterceptorAdapter {

    private static final String[] IGNORE_URI = {"/", "/login", "/register", "/admin/login", "/getProducts"
        , "/getShops"};
    private static final String[] UNLOGIN_URI = {"/login", "/register", "/admin/login"};

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
                             Object handler) throws Exception {

        String url = request.getRequestURI();
        HttpSession session = request.getSession();
        if (session.getAttribute("id") != null) {
            for (String s : UNLOGIN_URI) {
                if (url.equals(s)) {
                    response.sendRedirect("/");
                    return false;
                }
            }

            if (url.startsWith("/admin") && (int)session.getAttribute("role") == 5) {
                response.sendRedirect("/");
                return false;
            }

        } else {
            boolean flag = false;
            for (String s : IGNORE_URI) {
                if (url.equals(s)) {
                    flag = true;
                }
            }
            if (!flag) {
                if (url.startsWith("/admin")) {
                    response.sendRedirect("/admin/login");
                } else {
                    response.sendRedirect("/login");
                }
                return false;
            }
        }
        return true;
    }

}
