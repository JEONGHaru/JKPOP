package com.haru.mapper;

import org.apache.ibatis.annotations.Param;

import com.haru.domain.AlbumFileDTO;

public interface AlbumMapper {

	public int likeInsert(@Param("ano") int ano,@Param("userId") String userId);

	public int likeDelete(@Param("ano")int ano,@Param("userId") String userId);

	public int liked(@Param("ano")int ano,@Param("userId") String userId);
	
}
