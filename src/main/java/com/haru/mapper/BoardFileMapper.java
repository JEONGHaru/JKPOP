package com.haru.mapper;

import java.util.List;

import com.haru.domain.BoardFileDTO;

public interface BoardFileMapper {
	
	public int insert(BoardFileDTO dto);

	public void delete(String uuid);
	
	public List<BoardFileDTO> findByBno(int bno);
	
	public void deleteAll(int bno);
	
	public List<BoardFileDTO> getOldFiles();

}
