package com.haru.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberDTO {

	private String userId;
	private String userPassword;
	private String userFirstName;
	private String userLastName;
	private String email;
	private Date regDate;
	private Date updateDate;
	private boolean enabled;
	private List<AuthDTO> authList;
	
}
