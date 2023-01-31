package com.haru.service;

import java.util.List;

import com.haru.domain.AlbumDTO;
import com.haru.domain.AlbumFileDTO;

public interface AlbumService {

	public void insert(AlbumFileDTO dto);

	public List<AlbumFileDTO> getAlbumImage(AlbumDTO dto);

	public int likeAdd(int ano, String userId);

	public int likeCancel(int ano, String userId);

	public AlbumFileDTO getImage(int ano);

	public void deleteImage(int ano);

	public void getLiked(List<AlbumFileDTO> list, String userId);

	public List<AlbumFileDTO> getMainImage();

	
}
