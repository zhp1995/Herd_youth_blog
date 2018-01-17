package cn.tjz.interceptor;

import java.net.Inet4Address;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * <p>
 * 登录拦截器
 * </p>
 * 
 * @author: tjz
 */
public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	private static Log access = LogFactory.getLog("access");

	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
	 	access.info(request.getRemoteHost()+" "+request.getHeader("User-Agent")+" "+request.getRequestURL()+" "+request.getRemoteUser());
		
       if(request.getRequestURI().indexOf("/admin")>0){
    	   if(request.getRequestURI().indexOf("/admin/toLogin.shtml")>0 ||
    	      request.getRequestURI().indexOf("/admin/login.shtml")>0){
    		   return super.preHandle(request, response, handler);
    	   }
    	   Object obj = request.getSession().getAttribute("user");
    	   if(obj==null){
    		   response.sendRedirect(request.getContextPath()+"/admin/toLogin.shtml");
    		   return false;
    	   }else{
    		   return super.preHandle(request, response, handler);
    	   }
       }
       return super.preHandle(request, response, handler);
    }
    
}