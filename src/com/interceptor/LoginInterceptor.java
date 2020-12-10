package com.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
            throws Exception {
        // TODO 自动生成的方法存根


    }

    @Override
    public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
            throws Exception {
        // TODO 自动生成的方法存根

    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception {

        // 获取URL
        String url = request.getRequestURI();
        // 拦截除了登录、注册之外的所有请求
        if (url.indexOf("/login") > 0 || url.indexOf("/toregister") > 0 || url.indexOf("/register") > 0) {
            return true;
        }
        // 获取session
        HttpSession session = request.getSession();
        // 获取登录信息
        String account = (String) session.getAttribute("account");
        if (account != null && account!="") {
            return true;
        }
        // 拦截给出提示信息，请求转发
        /*response.setCharacterEncoding("UTF-8");
        response.setHeader("Content-Type", "text/html;charset=UTF-8");//这句话是解决乱码的
        PrintWriter writer = response.getWriter();*/
        request.setAttribute("msg", "Please Login!");
        request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
        return false;
    }

}