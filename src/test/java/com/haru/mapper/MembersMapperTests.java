package com.haru.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.haru.domain.MemberDTO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MembersMapperTests {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Test
	public void testRead() {
		
		MemberDTO dto = mapper.read("admin90");
		
		log.info(dto);
		
		dto.getAuthList().forEach(auth -> {
			log.info(auth);
		});
		
	
		
	}
	
}
