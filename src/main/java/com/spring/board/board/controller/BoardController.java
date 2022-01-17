package com.spring.board.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.board.board.model.service.BoardService;
import com.spring.board.board.model.vo.Board;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board")
@Slf4j
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	
	@GetMapping("/springBoardList.do")
	public void boardList(
			Model model,
			@RequestParam(defaultValue = "1") int cPage) {
		int limit = 10;
		int offset = (cPage - 1) * limit;
		Map<String, Object> map = new HashMap<>();
		map.put("limit", limit);
		map.put("offset", offset);
		List<Board> list = boardService.selectBoardList(map);
		model.addAttribute("list", list);
	}
}
