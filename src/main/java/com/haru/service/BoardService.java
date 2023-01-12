package com.haru.service;

import java.util.List;

import com.haru.domain.BoardDTO;
import com.haru.domain.Criteria;

public interface BoardService {

	public List<BoardDTO> getList(Criteria criteria); //ページングList
	
	public int getTotal(Criteria criteria);
}
