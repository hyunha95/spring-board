package com.spring.board.board.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.spring.board.board.model.vo.Attachment;
import com.spring.board.board.model.vo.Board;

public interface BoardService {

	List<Board> selectBoardList(Map<String, Object> map);

	int selectTotalBoardCount();

	int insertBoard(Board board);
	
	int insertAttachment(Attachment attach);

	Board selectOneBoard(int no);

	int updateReadCount(int no);

	Attachment selectOneAttachment(int no);

	int updateBoard(Board board);

	int deleteAttachment(int delFileNo);

	int deleteBoard(int no);

	List<Attachment> selectAttachmentsByNo(int no);
	
}
