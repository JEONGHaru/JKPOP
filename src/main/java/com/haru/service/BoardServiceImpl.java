package com.haru.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.haru.domain.BoardDTO;
import com.haru.domain.Criteria;
import com.haru.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor //constructorでDI
public class BoardServiceImpl implements BoardService {

	private BoardMapper mapper;
	
	@Override
	public List<BoardDTO> getList(Criteria cri) {
		log.info("board LIst ------------------- cri: " + cri);
		return mapper.getList(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) {
		log.info("total page -------------- : " + cri);
		
		return mapper.getTotalCount(cri);
	}

}
