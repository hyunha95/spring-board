package com.spring.board.board.controller;

import java.beans.PropertyEditor;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	@Autowired ResourceLoader resourceLoader;
	
	@GetMapping("/springBoardDetail.do")
	public String springBoardDetail(
			@RequestParam int no, 
			Model model,
			HttpServletRequest request,
			HttpServletResponse response) {
		log.debug("no = {}", no);
		
		// ??????????????? ????????????, ???????????? ?????? boardCookie??? ???????????? ?????? ??? ???????????? 1 ????????????.
		// a.??????
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
		
		// b.?????????
		if(!hasRead) {
			int result = boardService.updateReadCount(no);
			
			Cookie cookie = new Cookie("boardCookie", boardCookieVal + "[" + no + "]");
			cookie.setPath(request.getContextPath() + "/board/springBoardDetail.do");
			cookie.setMaxAge(24 * 60 * 60); // 1????????? ????????????
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
		// ??????????????? ????????? ??????
		String saveDirectory = application.getRealPath("/resources/upload/board");
		List<Attachment> attachments = new ArrayList<>();
		
		// 1. ??????????????? ?????????????????? ?????? : rename
		// 2. ????????? ????????? ?????? -> Attachment?????? -> attachment insert
		for(int i = 0; i < upFiles.length; i++) {
			MultipartFile upFile = upFiles[i];
			if(!upFile.isEmpty()) {
				String originalFilename = upFile.getOriginalFilename();
				// 1. ??????????????? rename??? ?????????????????? ????????????.
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
		String msg = result > 0 ? "????????? ?????? ??????" : "????????? ?????? ??????";
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

		// content ??????
		List<Board> list = boardService.selectBoardList(map);
		model.addAttribute("list", list);
		
		// pagebar ??????
		int totalContent = boardService.selectTotalBoardCount();
		log.debug("totalContent = {}", totalContent);
		String url = request.getRequestURI();
		String pagebar = HelloSpringUtils.getPagebar(cPage, limit, totalContent, url);
		model.addAttribute("pagebar", pagebar);
	}
	
	@GetMapping(value="/fileDownload.do", 
				produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public Resource fileDownload(@RequestParam int no, HttpServletResponse response) throws UnsupportedEncodingException {
		Attachment attach = boardService.selectOneAttachment(no);
		log.debug("attach = {}", attach);
		
		// ???????????? ?????? ??????
		String saveDirectory = application.getRealPath("/resources/upload/board");
		File downFile = new File(saveDirectory, attach.getRenamedFilename());
		String location = "file:" + downFile;
		log.debug("location = {}", location);
		Resource resource = resourceLoader.getResource(location);
		
		// ????????????
		String filename = new String(attach.getOriginalFilename().getBytes("utf-8"), "iso-8859-1");
		response.addHeader(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + filename);
		
		return resource;
	}
	
	@GetMapping("/springUpdateBoard.do")
	public void springUpdateBoard(@RequestParam int no, Model model) {
		Board board = boardService.selectOneBoard(no);
		model.addAttribute(board);
	}
	
	@PostMapping(value="/springUpdateBoard.do")
	public String springUpdateBoard(
			@ModelAttribute Board board, 
			@RequestParam(value = "delFile", required = false) String[] delFiles,
			@RequestParam(value = "upFile", required = false) MultipartFile[] upFiles,
			RedirectAttributes ra) throws IllegalStateException, IOException {
		log.debug("board = {}", board);
		log.debug("delFiles = {}", delFiles);
		log.debug("upFiles = {}", upFiles);
		
		// board????????? ?????? ??????, ?????? ???????????? ??????, ????????? ???????????? ????????? ?????? ??? ?????????????????? ????????????
		// ?????? ???????????? ????????? ??????????????? ??????
		String saveDirectory = application.getRealPath("/resources/upload/board");
		String msg = "";
		
		if(upFiles != null) {
			List<Attachment> attachments = new ArrayList<>();
			for(MultipartFile upFile : upFiles) {
				String originalFilename = upFile.getOriginalFilename();
				String renamedFilename = HelloSpringUtils.rename(originalFilename);
				File dest = new File(saveDirectory, renamedFilename);
				upFile.transferTo(dest);
				
				Attachment attach = new Attachment();
				attach.setOriginalFilename(originalFilename);
				attach.setRenamedFilename(renamedFilename);
				attachments.add(attach);
			}
			
			if(!attachments.isEmpty())
				board.setAttachments(attachments);
		}
		
		// ?????? ???????????? ??????
		if(delFiles != null) {
			for(String temp : delFiles) {
				int delFileNo = Integer.parseInt(temp);
				Attachment attach = boardService.selectOneAttachment(delFileNo);
				
				// 1. ???????????? ?????? : {saveDirectory}/{renamedFilename}
				String renamedFilename = attach.getRenamedFilename();
				File delFile = new File(saveDirectory, renamedFilename);
				boolean removed = delFile.delete();
				
				// 2. DB ???????????? ????????? ??????
				int result = boardService.deleteAttachment(delFileNo);
				
				if(removed && result > 0 )
					msg += "??????????????????" + attach.getOriginalFilename() + " ?????? ??????\\n";
				else
					msg += "?????????????????? ?????? ??????\\n";
			}
		}
		
		// ????????? ??????, ?????? ??????
		int result = boardService.updateBoard(board);
		msg += "????????? ?????? ??????!!!!";
		ra.addFlashAttribute("msg", msg);
		
		return "redirect:/board/springBoardDetail.do?no=" + board.getNo();
	}
	
	// InitBinder??????????????? @DateTimeFormat??????
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		// boolean allowEmpty - true ???????????? ""??? ?????? null?????????
		PropertyEditor editor = new CustomDateEditor(sdf, true);
		binder.registerCustomEditor(Date.class, editor);
	}
	
	@GetMapping("springBoardDelete.do")
	public String springBoardDelete(@RequestParam int no, RedirectAttributes ra) {
		// 1. ????????? ?????? ??????: java.io.File api ????????????
		String saveDirectory = application.getRealPath("/resources/upload/board");
		String msg = "";
		// board???????????? no??? ???????????? ?????? attachment???????????? ???
		List<Attachment> attachments = boardService.selectAttachmentsByNo(no);
		if(!attachments.isEmpty()) {
			for(Attachment attach : attachments) {
				String renamedFilename = attach.getRenamedFilename();
				File delFile = new File(saveDirectory, renamedFilename);
				boolean removed = delFile.delete();
				if(removed)
					msg += attach.getOriginalFilename() + "????????? ??????\\n";
			}			
		}
		
		// 2. board???????????? ??? ??????
		// board.no??? ???????????? ?????? attachment???????????? ?????? on delete cascade??? ?????? ??????
		int result = boardService.deleteBoard(no);
		msg += result > 0 ? "????????? ?????? ??????" : "????????? ?????? ??????";
		
		ra.addFlashAttribute("msg", msg);
		
		return "redirect:/board/springBoardList.do";
	}
	
}

























