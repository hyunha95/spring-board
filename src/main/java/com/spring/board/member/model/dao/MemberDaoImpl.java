package com.spring.board.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.member.model.vo.MemberEntity;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public int insertMember(MemberEntity member) {
		return session.insert("member.insertMember", member);
	}

	@Override
	public int insertAuthority(MemberEntity member) {
		return session.insert("member.insertAuthority", member);
	}

	
}
