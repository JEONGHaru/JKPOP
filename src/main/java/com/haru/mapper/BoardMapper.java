package com.haru.mapper;

import java.util.List;

import com.haru.domain.BoardDTO;
import com.haru.domain.Criteria;

public interface BoardMapper {

	// WHERE bno >0 -> 인덱스를 구성하고 있는 것으로 검색하면 처리 속도가 빨라짐
		//@Select("SELECT * FROM board WHERE bno > 0")
		public List<BoardDTO> getList(Criteria criteria);
		
		public int getTotalCount(Criteria criteria);
}
