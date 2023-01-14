package com.haru.domain;

import java.util.Date;

import lombok.Data;

@Data
public class UserDTO {

	private String id;
	private String password;
	private String userName;
	private String role;
	private String email;
	private String emailHashCode;
	private Date regDate;
}
