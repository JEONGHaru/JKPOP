package com.haru.service;

import javax.mail.internet.MimeMessage;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml","file:src/main/webapp/WEB-INF/spring/security-context.xml"})
public class MailTests {

	@Setter(onMethod_ = @Autowired)
	private JavaMailSender mailSender;
	
	
	@Test
	public void mailSendTest() {
	
		String subject = "테스트용 메일";
		String context = "테스트용 메일";
		
		String from = "holyanegl24";
		
		String to = "holyanegl@gmail.com";
		
	
		try {
			MimeMessage mail = mailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail,"UTF-8");
			mailHelper.setFrom(from);
			mailHelper.setTo(to);
			mailHelper.setSubject(subject);
			mailHelper.setText(context);
			
			mailSender.send(mail);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
		
		
	}
	
}
