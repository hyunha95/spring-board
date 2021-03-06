package com.spring.board.board.model.dao;

import java.util.List;
import java.util.Map;

import com.spring.board.board.model.vo.Attachment;
import com.spring.board.board.model.vo.Board;

public interface BoardDao {

	List<Board> selectBoardList(Map<String, Object> map);

	int selectTotalBoardCount();

	int insertBoard(Board board);

	Board selectOneBoard(int no);

	int updateReadCount(int no);

	int insertAttachment(Attachment attach);

	List<Attachment> selectAttachmentByBoardNo(int no);

	Attachment selectOneAttachment(int no);

	int deleteAttachment(int delFileNo);

	int updateBoard(Board board);

	int deleteBoard(int no);

	List<Attachment> selectAttachmentsByNo(int no);
	
	

}
