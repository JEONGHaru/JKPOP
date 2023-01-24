package com.haru.service;

import com.haru.domain.MemberDTO;

public interface MemberService {

	public int createMember(MemberDTO dto);

	public int findByMemberid(String userId);

	
}
