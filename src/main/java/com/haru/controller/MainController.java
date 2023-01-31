package com.haru.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.haru.domain.AlbumFileDTO;
import com.haru.service.AlbumService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MainController {

	@Setter(onMethod_ = @Autowired)
	private AlbumService service;
	
	@GetMapping("/main")
	public void main(Model model) {

		log.info("mainController ------------------------ ");
		
		List<AlbumFileDTO> list = service.getMainImage();
		List<AlbumFileDTO> kList = new ArrayList<AlbumFileDTO>();
		List<AlbumFileDTO> jList = new ArrayList<AlbumFileDTO>();

		
		
		for(AlbumFileDTO dto : list) {
			if(dto.getNation().equals("korea")) {
				kList.add(dto);
			}else if(dto.getNation().equals("japan")) {
				jList.add(dto);
			}
		}
		
		model.addAttribute("list",list);
		model.addAttribute("kList",kList);
		model.addAttribute("jList",jList);
		log.info("MainController ---------------- list : " + list);
	}
}
