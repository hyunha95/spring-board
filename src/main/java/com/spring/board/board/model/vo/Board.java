package com.spring.board.board.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString(callSuper=true)
@NoArgsConstructor
public class Board extends BoardEntity implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int attachCount;

	public Board(int no, String title, String content, String memberId, Date regDate, int readCount, int attachCount) {
		super(no, title, content, memberId, regDate, readCount);
		this.attachCount = attachCount;
	}
	
	
}
