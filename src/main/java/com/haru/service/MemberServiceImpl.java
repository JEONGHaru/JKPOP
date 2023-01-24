package com.haru.service;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.haru.domain.MemberDTO;
import com.haru.mapper.MemberMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class MemberServiceImpl implements MemberService {

	private MemberMapper mapper;
	private PasswordEncoder pwencoder;
	
	@Transactional
	@Override
	public int createMember(MemberDTO dto) {
	
		log.info("MemberService createMember -------------------- MemberDTO : " + dto);
		//memberのパスワードを暗号化
		dto.setUserPassword(pwencoder.encode(dto.getUserPassword()));
		int result =  mapper.createMember(dto);
		dto.getAuthList().forEach(auth ->{
			mapper.authorizeMember(auth);
		});
		log.info("MemberService createMember -------------------- MemberDTO : " + dto);
		return result;
	}

	@Override
	public int findByMemberid(String userId) {
		log.info("MemberService------------------------------ userId : " + userId);
		
		return mapper.findByMemberId(userId);
	}


	

}
