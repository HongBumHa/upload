package com.dgit.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;



public class LoginInterceptor extends HandlerInterceptorAdapter{
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		logger.info("PostHandle==================");
		
		HttpSession session = request.getSession();
		Object obj = modelAndView.getModel().get("id");
		if(obj !=null){
			logger.info("obj not null==================");
			session.setAttribute("id",obj);
		}else{
			logger.info("obj null");
		}
	}
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.info("PreHandle==================");
		System.out.println("preHandle=====");
		HttpSession session = request.getSession();
		
		if(session.getAttribute("id") !=null){
			logger.info("이전 login 정보 삭제");
			session.removeAttribute("id");
		}
		return true;
	}	
}