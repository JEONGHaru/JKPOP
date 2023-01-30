package com.haru.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

@Data
public class AlbumFileDTO {

	private int ano;
	private String nation;
	private String year;
	private String fileName;
	private String uploadPath;
	private int likeCnt;
	private boolean liked;
	
	
	public String getListLink() {
		UriComponentsBuilder builder =UriComponentsBuilder.fromPath(this.nation)
																.queryParam("year",this.year);
		
		return builder.toUriString();
	}
}
