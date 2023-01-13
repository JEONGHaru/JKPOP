package com.haru.domain;

import lombok.Data;

@Data
public class UploadFileDTO {

	private String fileName; //ファイル名
	private String uploadPath; //
	private String uuid; //
	private boolean image;
}
