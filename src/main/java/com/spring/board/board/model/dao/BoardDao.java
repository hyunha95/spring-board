package com.spring.board.board.model.dao;

import java.util.List;
import java.util.Map;

import com.spring.board.board.model.vo.Board;

public interface BoardDao {

	List<Board> selectBoardList(Map<String, Object> map);

	int selectTotalBoardCount();

}
