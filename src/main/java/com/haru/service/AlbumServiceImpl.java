package com.haru.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.haru.domain.AlbumDTO;
import com.haru.domain.AlbumFileDTO;
import com.haru.mapper.AlbumFileMapper;
import com.haru.mapper.AlbumMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class AlbumServiceImpl implements AlbumService {

	
	@Setter(onMethod_ = @Autowired)
	private AlbumFileMapper fileMapper;
	
	@Setter(onMethod_ = @Autowired)
	private AlbumMapper mapper;
	
	@Override
	public void insert(AlbumFileDTO dto) {

		fileMapper.insert(dto);
		
	}

	@Override
	public List<AlbumFileDTO> getAlbumImage(AlbumDTO dto) {
		
		log.info("AlbumService ---------------------------- dto : " + dto);
		
		return fileMapper.getImageList(dto);
	}

	@Transactional
	@Override
	public int likeAdd(int ano, String userId) {
		
		int result = mapper.likeInsert(ano, userId);
		fileMapper.likePlus(ano);
		return result;
		
	}

	@Transactional
	@Override
	public int likeCancel(int ano, String userId) {
		
		int result = mapper.likeDelete(ano,userId);
		log.info("likeCancel-------------"+result);
		if(result == 1) {
			fileMapper.likeCancel(ano);
		}
		return result;
	}

	@Override
	public AlbumFileDTO getImage(int ano) {

		return fileMapper.getImage(ano);
		
	}

	@Override
	public void deleteImage(int ano) {

		fileMapper.delete(ano);
		
	}

	@Override
	public void getLiked(List<AlbumFileDTO> list, String userId) {
		
		for(AlbumFileDTO dto : list) {
			int result = mapper.liked(dto.getAno(), userId);
			log.info("getLiked ------------------ result : " + result);
			if(result == 1) dto.setLiked(true);
		}
		
	}

	@Override
	public List<AlbumFileDTO> getMainImage() {
		log.info("AlbumService getMainImage ------------------");
		
		return fileMapper.getMainImage();
	}

}
