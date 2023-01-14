package com.haru.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.haru.domain.BoardDTO;
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
	
	@PostMapping("write")
	public String write(BoardDTO dto,RedirectAttributes rttr) {
		log.info("boardController write POST --------------------------------");
		log.info("boardController---------------- BoardDTO : "+dto);
		int result = service.insert(dto);
		if(result == 1) {
			rttr.addFlashAttribute("result","登録しました");
			return "redirect:list";
		}else {
			return "redirect:write";
		}
	}
	
	@GetMapping({"detail","update"})
	public void detail(int bno,Model model) {
		log.info("boardController detail,update GET ----------------------" + bno);
		model.addAttribute("board", service.getDetail(bno));
	}
	
	@PostMapping("update")
	public String modify(BoardDTO dto,Criteria cri,RedirectAttributes rttr) {
		log.info("boardController update POST ---------------------- BoardDTO : " + dto );
		log.info("boardController update POST ---------------------- Criteria : " + cri);
		
		if(service.update(dto)) rttr.addFlashAttribute("result","修正しました");
		
		return "redirect:detail?bno="+dto.getBno()
					+"&pageNum="+cri.getPageNum()
					+"&amount="+cri.getAmount()
					+"&field="+cri.getField()
					+"&keyword="+cri.getKeyword();
	}
	
	@PostMapping("delete")
	public String delete(int bno,RedirectAttributes rttr) {
		log.info("boardController delete POST ---------------------- BoardDTO : " + bno );
		
		if(service.delete(bno)) rttr.addFlashAttribute("result","削除しました");
		
		return "redirect:list";
	}
}
