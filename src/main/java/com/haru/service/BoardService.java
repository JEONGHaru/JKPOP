package com.haru.service;

import java.util.List;

import com.haru.domain.BoardDTO;
import com.haru.domain.BoardFileDTO;
import com.haru.domain.Criteria;

public interface BoardService {

	public List<BoardDTO> getList(Criteria cri); //ページングList
	
	public int getTotalCount(Criteria cri);
	
	public int insert(BoardDTO dto);

	public BoardDTO getDetail(int bno);
	public List<BoardFileDTO> getFileList(int bno);//detail fileList

	public boolean update(BoardDTO dto);

	public boolean delete(int bno);
	
}
