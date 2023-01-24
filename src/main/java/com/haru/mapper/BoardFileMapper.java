package com.haru.mapper;

import java.util.List;

import com.haru.domain.BoardFileDTO;

public interface BoardFileMapper {
	
	public int insert(BoardFileDTO dto);

	public List<BoardFileDTO> findByBno(int bno);
	
	public List<BoardFileDTO> getOldFiles();

}
