package com.haru.service.email;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.haru.domain.EmailDTO;

import lombok.Setter;

@Service
public class EmailSender {

	@Setter(onMethod_ = @Autowired)
	private JavaMailSender mailSender;
	
	private final String FROM_ADDRESS = "holyanegl24";
	
	public void mailsend(EmailDTO dto) throws MessagingException {
	
		MimeMessage mail = mailSender.createMimeMessage();
		MimeMessageHelper mailHelper = new MimeMessageHelper(mail,"UTF-8");
		mailHelper.setFrom(FROM_ADDRESS);
		mailHelper.setTo(dto.getAddress());
		mailHelper.setSubject(dto.getSubject());
		mailHelper.setText(dto.getContent());
		
		mailSender.send(mail);
		
	}
}
