package com.haru.controller;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.haru.domain.BoardDTO;
import com.haru.domain.BoardFileDTO;
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
		//log.info("boardController list ------------- criteria :" + cri);
		model.addAttribute("list",service.getList(cri));
		
		//画面に必要な情報
		model.addAttribute("pageMaker",new PageDTO(cri, service.getTotalCount(cri)));
		log.info("boardController list ------------- model :" + model);
		log.info("boardController list ------------- amount :" + cri.getAmount());
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("write")
	public void writeForm() {
		log.info("boardController writeForm---------------------------");
	}
	
	@PreAuthorize("isAuthenticated()")
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
	
	@GetMapping(value ="getFileList" , produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardFileDTO>> getFileLIst(int bno){
		log.info("boardController getFileList ----------------------" + bno);
		return new ResponseEntity<List<BoardFileDTO>>(service.getFileList(bno),HttpStatus.OK);
	}
	
	@PreAuthorize("principal.username == #dto.writer")
	@PostMapping("update")
	public String modify(BoardDTO dto,Criteria cri,RedirectAttributes rttr) {
		log.info("boardController update POST ---------------------- BoardDTO : " + dto );
		log.info("boardController update POST ---------------------- Criteria : " + cri);
		
		if(service.update(dto)) rttr.addFlashAttribute("result","修正しました");
		
		return "redirect:detail?bno="+dto.getBno()+"&PageNum="+cri.getPageNum()
					+"&amount="+cri.getAmount()+"field="+cri.getField()+"&keyword="+cri.getKeyword();
	}
	
	@PreAuthorize("principal.username == #writer")
	@PostMapping("delete")
	public String delete(@RequestParam("bno") int bno,Criteria cri,RedirectAttributes rttr, String writer) {
		log.info("boardController delete POST ---------------------- BoardDTO : " + bno );
		log.info("boardController delete POST ---------------------- Criteria : " + cri );
		log.info("boardController delete POST ---------------------- writer : " + writer);
		List<BoardFileDTO> uploadFileLIst = service.getFileList(bno);
		
		if(service.delete(bno)) {
			
			deleteFiles(uploadFileLIst);
			rttr.addFlashAttribute("result","削除しました");
		}
		
		return "redirect:list"+cri.getListLink();
	}
	
	private void deleteFiles(List<BoardFileDTO> uploadFileList)  {
		
		if(uploadFileList == null || uploadFileList.size() == 0) {
			return;
		}
		log.info("boardController deleteFiles  ---------------------- uploadFileList : " + uploadFileList );
		
		uploadFileList.forEach(f ->{
			try {
			Path file = Paths.get("/Users/jeong-gwang-yeong/Desktop/upload/tmp/images" +File.separator+ f.getUploadPath()+File.separator
		+ f.getUuid()+"_" +f.getFileName());
				Files.deleteIfExists(file);
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail =  Paths.get("/Users/jeong-gwang-yeong/Desktop/upload/tmp/images"+File.separator + f.getUploadPath()+File.separator+"s_"
							+ f.getUuid()+"_" +f.getFileName());
					Files.delete(thumbNail);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		});
	}
	
}
