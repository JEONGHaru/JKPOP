package com.haru.service;

import javax.mail.MessagingException;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.haru.domain.EmailDTO;
import com.haru.domain.MemberDTO;
import com.haru.mapper.MemberMapper;
import com.haru.service.email.EmailSender;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class MemberServiceImpl implements MemberService {

	private MemberMapper mapper;
	private PasswordEncoder pwencoder;
	private EmailSender emailSender;
	@Transactional
	@Override
	public int createMember(MemberDTO dto) {

		log.info("MemberService createMember -------------------- MemberDTO : " + dto);
		// memberのパスワードを暗号化
		dto.setUserPassword(pwencoder.encode(dto.getUserPassword()));
		int result = mapper.createMember(dto);
		dto.getAuthList().forEach(auth -> {
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

	
	@Override
	public MemberDTO findByMemberPw(MemberDTO dto) {

		MemberDTO result = mapper.findByMember(dto);
		log.info("findByMemberPw--------------" +result);
		if (result != null) {
			String resetPw = getRandomPassword(6);
			log.info(resetPw);
			
			try {
				EmailDTO email = new EmailDTO();
				email.setAddress(dto.getEmail());
				email.setSubject("臨時パスワード");
				email.setContent("臨時パスワードは"+resetPw+"です");
				emailSender.mailsend(email);
			} catch (MessagingException e) {
				e.printStackTrace();
			}
			dto.setUserPassword(pwencoder.encode(resetPw));
			mapper.resetMemberPw(dto);
		}
		return result;
	}
	@Override
	public int changeMemberPw(MemberDTO dto) {
		
		String resetPw = pwencoder.encode(dto.getUserPassword());
		dto.setUserPassword(resetPw);
		int result = mapper.resetMemberPw(dto);
		
		return result;
	}

	private String getRandomPassword(int size) {
		return RandomStringUtils.randomAlphanumeric(size); 
	}

}
