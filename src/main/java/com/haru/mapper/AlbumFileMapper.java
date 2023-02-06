package com.haru.mapper;

import java.util.List;

import com.haru.domain.AlbumDTO;
import com.haru.domain.AlbumFileDTO;

public interface AlbumFileMapper {

	public void insert(AlbumFileDTO dto);

	public List<AlbumFileDTO> getImageList(AlbumDTO dto);

	public void likePlus(int ano);
	
	public void likeCancel(int ano);

	public AlbumFileDTO getImage(int ano);

	public void delete(int ano);

	public List<AlbumFileDTO> getMainImage();

	public List<AlbumFileDTO> getImages();
	
}
