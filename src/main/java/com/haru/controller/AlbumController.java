package com.haru.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/album")
public class AlbumController {

	
	@GetMapping("/{nation}")
	public void alubmList(@PathVariable("nation")String nation, String year,Model model) {
		log.info("albumController--------------------- year : " + year);
		log.info("albumController--------------------- nation : " + nation);
		
		model.addAttribute("year",year);
	}
	
}
