package com.haru.mapper;

import com.haru.domain.AuthDTO;
import com.haru.domain.MemberDTO;

public interface MemberMapper {

	public MemberDTO read(String userId);
	
	public int createMember(MemberDTO dto);
	
	public int findByMemberId(String userId);

	public void authorizeMember(AuthDTO dto);

}
