package com.haru.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.haru.domain.MemberDTO;
import com.haru.mapper.MemberMapper;
import com.haru.security.domain.CustomUser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService{
	
	@Setter(onMethod_ =@Autowired)
	private MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
		
		log.info("User By UserName ----------------- : " + userName);
		
		MemberDTO dto = memberMapper.read(userName);
		
		log.info("memberMapper ---------------------------- dto : " + dto);
		return dto == null ? null : new CustomUser(dto);
	}

}
