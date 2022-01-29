package com.spring.board.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
		
		String id = request.getParameter("id");
		String saveId = request.getParameter("saveId");
		log.debug("saveId = {}", saveId);
		
		// 아이디 저장
		// create:boolean - session객체가 존재하면 해당객체를 리턴, 존재하지 않으면 새로 만들어서 리턴
		HttpSession session = request.getSession(true);
		// timeout설정 - web.xml설정보다 우선순위가 높다.
		
		Cookie cookie = new Cookie("saveId", id);
		cookie.setPath(request.getContextPath());
		if(saveId != null) {
			cookie.setMaxAge(7 * 24 * 60 * 60); // 7일짜리 영속쿠키
		} else {
			cookie.setMaxAge(0);
		}
		response.addCookie(cookie);
		
		String location = request.getContextPath() + "/";
		response.sendRedirect(location);

	}

}
