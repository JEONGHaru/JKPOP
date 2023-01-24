package com.haru.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {

	
	@GetMapping("/error")
	public void accessDenide(Authentication auth, Model model) {
		log.info("access 拒絶");
		model.addAttribute("msg","403");
		
	}
	
}
