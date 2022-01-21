package com.spring.board.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.board.board.model.service.BoardService;
import com.spring.board.board.model.vo.Attachment;
import com.spring.board.board.model.vo.Board;
import com.spring.board.common.util.HelloSpringUtils;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board")
@Slf4j
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	@Autowired
	private ServletContext application;
	
	@GetMapping("/springBoardDetail.do")
	public String springBoardDetail(
			@RequestParam int no, 
			Model model,
			HttpServletRequest request,
			HttpServletResponse response) {
		log.debug("no = {}", no);
		
		// 상세보기를 요청하면, 해당글에 대한 boardCookie가 존재하지 않을 때 조회수를 1 증가한다.
		// a.검사
		Cookie[] cookies = request.getCookies();
		log.debug("cookies = {}", cookies);
		boolean hasRead = false;
		String boardCookieVal = "";
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				String name = cookie.getName();
				String value = cookie.getValue();
				log.debug("name, value = {}{}", name, value);
				if("boardCookie".equals(name)) {
					boardCookieVal = value;
					if(value.contains("[" + no + "]")) {
						hasRead = true;
						break;
					}
				}
			}
		}
		
		// b.조회수
		if(!hasRead) {
			int result = boardService.updateReadCount(no);
			
			Cookie cookie = new Cookie("boardCookie", boardCookieVal + "[" + no + "]");
			cookie.setPath(request.getContextPath() + "/board/springBoardDetail.do");
			cookie.setMaxAge(24 * 60 * 60); // 1일짜리 영속쿠키
			response.addCookie(cookie);
		}
		
		Board board = boardService.selectOneBoard(no);
		log.debug("board = {}", board);
		model.addAttribute("board", board);
		
		return "board/springBoardDetail";
	}
	
	@PostMapping("/springBoardEnroll.do")
	public String springBoardEnroll(
			@ModelAttribute Board board,
			@RequestParam(value="upFile", required=false) MultipartFile[] upFiles,
			RedirectAttributes redirectAttr
			) throws IllegalStateException, IOException {
		// 첨부파일이 저장될 경로
		String saveDirectory = application.getRealPath("/resources/upload/board");
		List<Attachment> attachments = new ArrayList<>();
		
		// 1. 첨부파일을 서버컴퓨터에 저장 : rename
		// 2. 저장된 파일의 정보 -> Attachment객체 -> attachment insert
		for(int i = 0; i < upFiles.length; i++) {
			MultipartFile upFile = upFiles[i];
			if(!upFile.isEmpty()) {
				String originalFilename = upFile.getOriginalFilename();
				// 1. 저장경로에 rename된 파일이름으로 저장한다.
				String renamedFilename = HelloSpringUtils.rename(originalFilename);
				File dest = new File(saveDirectory, renamedFilename);
				upFile.transferTo(dest);
				
				Attachment attach = new Attachment();
				attach.setOriginalFilename(originalFilename);
				attach.setRenamedFilename(renamedFilename);
				attachments.add(attach);
			}
		}
		
		if(!attachments.isEmpty()) 
			board.setAttachments(attachments);
		
		log.debug("board = {}", board);
		int result = boardService.insertBoard(board);
		String msg = result > 0 ? "게시글 등록 성공" : "게시글 등록 실패";
		redirectAttr.addFlashAttribute("msg", msg);
		return "redirect:/board/springBoardList.do";
	}
	
	@GetMapping("/springBoardForm.do")
	public void springBoardForm() {}
	
	@GetMapping("/springBoardList.do")
	public void boardList(
			Model model,
			HttpServletRequest request,
			@RequestParam(defaultValue = "1") int cPage) {
		int limit = 10;
		int offset = (cPage - 1) * limit;
		Map<String, Object> map = new HashMap<>();
		map.put("limit", limit);
		map.put("offset", offset);

		// content 영역
		List<Board> list = boardService.selectBoardList(map);
		model.addAttribute("list", list);
		
		// pagebar 영역
		int totalContent = boardService.selectTotalBoardCount();
		log.debug("totalContent = {}", totalContent);
		String url = request.getRequestURI();
		String pagebar = HelloSpringUtils.getPagebar(cPage, limit, totalContent, url);
		model.addAttribute("pagebar", pagebar);
	}
}