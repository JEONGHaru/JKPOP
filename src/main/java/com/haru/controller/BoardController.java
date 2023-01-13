package com.haru.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.haru.domain.Criteria;
import com.haru.domain.PageDTO;
import com.haru.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/")
@Log4j
@AllArgsConstructor
public class BoardController {

	private BoardService service;
	
	@GetMapping("list")
	public void list(Criteria cri,Model model) {
		log.info("boardController list ------------- criteria :" + cri);
		model.addAttribute("list",service.getList(cri));
		
		//画面に必要な情報
		model.addAttribute("pageMaker",new PageDTO(cri, service.getTotalCount(cri)));
		log.info("boardController list ------------- model :" + model);
		log.info("boardController list ------------- amount :" + cri.getAmount());
	}
	
	@GetMapping("write")
	public void writeForm() {
		log.info("boardController writeForm---------------------------");
	}
}
