package com.spring.board.member.model.dao;

import com.spring.board.member.model.vo.MemberEntity;

public interface MemberDao {

	int insertMember(MemberEntity member);

	int insertAuthority(MemberEntity member);

}
