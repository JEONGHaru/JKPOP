package com.haru.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class BoardDTO {

	private int bno;
	private String title;
	private String content;
	private String writer;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date regDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date updateDate;
}
