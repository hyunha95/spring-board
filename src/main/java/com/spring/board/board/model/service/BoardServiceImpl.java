package com.spring.board.board.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.board.board.model.dao.BoardDao;
import com.spring.board.board.model.vo.Attachment;
import com.spring.board.board.model.vo.Board;

@Service
@Transactional(rollbackFor = Exception.class)
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao boardDao;

	@Override
	public List<Board> selectBoardList(Map<String, Object> map) {
		return boardDao.selectBoardList(map);
	}

	@Override
	public int selectTotalBoardCount() {
		return boardDao.selectTotalBoardCount();
	}

	@Override
	public int insertBoard(Board board) {
		int result =  boardDao.insertBoard(board);
		List<Attachment> attachments = board.getAttachments();
		if(attachments != null) {
			for(Attachment attach : attachments) {
				// fk컬럼 boardNo값 설정
				attach.setBoardNo(board.getNo());
				result = insertAttachment(attach);
			}
		}
		return result;
	}

	@Override
	public int insertAttachment(Attachment attach) {
		return boardDao.insertAttachment(attach);
		
	}

	@Override
	public Board selectOneBoard(int no) {
		// 1. board테이블 조회
		Board board = boardDao.selectOneBoard(no);
		
		// 2. attachment테이블 조회
		List<Attachment> attachments = boardDao.selectAttachmentByBoardNo(no);
		
		// 3. 합치기
		board.setAttachments(attachments);
		
		return board;
	}

	@Override
	public int updateReadCount(int no) {
		return boardDao.updateReadCount(no);
	}

	@Override
	public Attachment selectOneAttachment(int no) {
		return boardDao.selectOneAttachment(no);
	}

	@Override
	public int updateBoard(Board board) {
		int result = boardDao.updateBoard(board);
		List<Attachment> attachments = board.getAttachments();
		if(attachments != null) {
			for(Attachment attach : attachments) {
				attach.setBoardNo(board.getNo());
				result = insertAttachment(attach);
			}
		}
		return result;
	}

	@Override
	public int deleteAttachment(int delFileNo) {
		return boardDao.deleteAttachment(delFileNo);
	}

	@Override
	public int deleteBoard(int no) {
		return boardDao.deleteBoard(no);
	}

	@Override
	public List<Attachment> selectAttachmentsByNo(int no) {
		return boardDao.selectAttachmentsByNo(no);
	}
	
	
	
	
	
}
