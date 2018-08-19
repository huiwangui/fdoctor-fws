package com.boco.common.exception;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

public class MyException implements HandlerExceptionResolver {

	@SuppressWarnings("finally")
	@Override
	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler,
			Exception ex) {
		Map<String, Object> model = new HashMap<String, Object>();  
        model.put("ex", ex);  
        StringWriter sw=new StringWriter();
        PrintWriter  pw =new PrintWriter(sw);
        try {
            ex.printStackTrace(pw);
            pw.flush();
            sw.flush();
            // 根据不同错误转向不同页面  
            if(ex instanceof BusinessException) {  
            	model.put("exMessage",ex.getMessage());
                return new ModelAndView("/error-business", model);  
            } else {  
            	model.put("exMessage",ex.getMessage());
                return new ModelAndView("/error", model);  
            }  
		}finally {
			if (sw != null) {
                try {
                    sw.close();
                } catch (IOException e1) {
                    e1.printStackTrace();
                }
            }
            if (pw != null) {
                pw.close();
            }
			
		}
        
    }  
	

}
