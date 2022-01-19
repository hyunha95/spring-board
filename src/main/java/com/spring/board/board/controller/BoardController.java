package com.spring.board.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.spring.board.board.model.service.BoardService;
import com.spring.board.board.model.vo.Board;
import com.spring.board.common.util.HelloSpringUtils;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board")
@Slf4j
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	@PostMapping("/springBoardEnroll.do")
	public String springBoardEnroll(@ModelAttribute Board board) {
		
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