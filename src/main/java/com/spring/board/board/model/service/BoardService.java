package com.spring.board.board.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.spring.board.board.model.vo.Board;

public interface BoardService {

	List<Board> selectBoardList(Map<String, Object> map);

	int selectTotalBoardCount();

	int insertBoard(Board board);

	Board selectOneBoard(int no);

	int updateReadCount(int no);
	
}
