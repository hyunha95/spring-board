package com.spring.board.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.board.model.vo.Attachment;
import com.spring.board.board.model.vo.Board;

@Repository
public class BoardDaoImpl implements BoardDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Board> selectBoardList(Map<String, Object> map) {
		int limit = (int) map.get("limit");
		int offset = (int) map.get("offset");
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("board.selectBoardList", null, rowBounds);
	}

	@Override
	public int selectTotalBoardCount() {
		return session.selectOne("board.selectTotalBoardCount");
	}

	@Override
	public int insertBoard(Board board) {
		return session.insert("board.insertBoard", board);
	}
	
	@Override
	public int insertAttachment(Attachment attach) {
		return session.insert("board.insertAttachment", attach);
	}

	@Override
	public Board selectOneBoard(int no) {
		return session.selectOne("board.selectOneBoard", no);
	}
	
	@Override
	public List<Attachment> selectAttachmentByBoardNo(int no) {
		return session.selectList("board.selectAttachmentByBoardNo", no);
	}

	@Override
	public int updateReadCount(int no) {
		return session.update("board.updateReadCount", no);
	}

	@Override
	public Attachment selectOneAttachment(int no) {
		return session.selectOne("board.selectOneAttachment", no);
	}

	@Override
	public int deleteAttachment(int delFileNo) {
		return session.delete("board.deleteAttachment", delFileNo);
	}

	@Override
	public int updateBoard(Board board) {
		return session.update("board.updateBoard", board);
	}

	@Override
	public int deleteBoard(int no) {
		return session.delete("board.deleteBoard", no);
	}

	@Override
	public List<Attachment> selectAttachmentsByNo(int no) {
		return session.selectList("board.selectAttachmentsByNo", no);
	}
	
	
	
}
