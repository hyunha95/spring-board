package com.spring.board.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomSuccessHandler implements AuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		log.debug("로그인 성공했습니다.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		log.debug("authentication = {}", authentication);
		
		
		
		String location = request.getContextPath() + "/";
		response.sendRedirect(location);

	}

}
