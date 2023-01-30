package com.haru.controller;

import java.io.File;
import java.nio.file.Files;
import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.haru.domain.AlbumDTO;
import com.haru.domain.AlbumFileDTO;
import com.haru.service.AlbumService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/album")
public class AlbumController {

	@Setter(onMethod_ = @Autowired)
	private AlbumService service;
	
	
	@GetMapping("/{nation}")
	public void alubmList(@PathVariable String nation,String year, Model model,Principal principal) {
		log.info("albumController--------------------- year : " +year);
		log.info("albumController--------------------- nation : " +nation);
		log.info("albumController--------------------- principal : " +principal);
		
		AlbumDTO dto = new AlbumDTO();
		dto.setNation(nation);
		dto.setYear(year);
		List<AlbumFileDTO> list = service.getAlbumImage(dto);
		if(principal != null) {
			service.getLiked(list,principal.getName());
		}
		model.addAttribute("image", list);
		model.addAttribute("year",year);
		log.info("albumController--------------------- model : " +model);
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping("uploadAlbum")
	public String albumImageUpload(MultipartFile[] uploadFile,AlbumDTO dto) throws Exception{
		log.info("AlbumController ------------------------ uploadAlbum");
		String uploadFolder = "/Users/jeong-gwang-yeong/Desktop/upload/album";
		String uploadFolderPath = dto.getNation()+File.separator+dto.getYear();
		File uploadPath = new File(uploadFolder,uploadFolderPath);
		
		for(MultipartFile multipartFile : uploadFile) {
			String fileName = multipartFile.getOriginalFilename();
			if(!uploadPath.exists()) uploadPath.mkdirs();
			File saveFile = new File(uploadPath,fileName);
			multipartFile.transferTo(saveFile);
			AlbumFileDTO albumFIle = new AlbumFileDTO();
			albumFIle.setFileName(fileName);
			albumFIle.setUploadPath(uploadFolderPath);
			albumFIle.setNation(dto.getNation());
			albumFIle.setYear(dto.getYear());
			log.info("AlbumController ------------------------albumFIle :  "+albumFIle);
			service.insert(albumFIle);
		}
		
		return "redirect:"+dto.getNation()+"?year="+dto.getYear();
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping("deleteImage")
	public String deleteImageFile(AlbumFileDTO dto){
		log.info("deleteImage ---------------- dto : " + dto);
		String uploadFolder =  "/Users/jeong-gwang-yeong/Desktop/upload/album";
		AlbumFileDTO result =  service.getImage(dto.getAno());
		if(result != null) {
			String uploadFolderPath = uploadFolder+File.separator+result.getUploadPath();
			String fileName = result.getFileName();
			File deleteFile = new File(uploadFolderPath,fileName);
			deleteFile.delete();
			service.deleteImage(dto.getAno());
			
		}
		return "redirect:"+dto.getListLink();
	
	}
	
	@GetMapping("display")
	@ResponseBody
	public ResponseEntity<byte[]> getfile(String fileName) throws Exception{
		ResponseEntity<byte[]> result = null;
		String uploadFolder = "/Users/jeong-gwang-yeong/Desktop/upload/album";
		log.info("display fileName================" + fileName);
		File file = new File(uploadFolder,fileName);
		
		HttpHeaders header = new HttpHeaders();
		
		header.add("content-type",Files.probeContentType(file.toPath()));
		
		result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file),header,HttpStatus.OK);
		
		return result;
	}
	
	@PostMapping("likeAdd")
	@ResponseBody
	public ResponseEntity<String> likeAdd(int ano, Principal principal){
		
		log.info("AlbumController likeAdd---------------------- ano : " + ano);
		log.info("AlbumController likeAdd---------------------- userId : " + principal);
		

		
		return service.likeAdd(ano,principal.getName() ) == 1
				? new ResponseEntity<String>("success",HttpStatus.OK)
				: new ResponseEntity<String>("fail",HttpStatus.NOT_MODIFIED);
	}
	
	@PostMapping("likeCancel")
	@ResponseBody
	public ResponseEntity<String> likeCancel(int ano, Principal principal){
		
		log.info("AlbumController likeCancel---------------------- ano : " + ano);
		log.info("AlbumController likeCancel---------------------- userId : " + principal.getName());
		
		
		return service.likeCancel(ano, principal.getName()) == 1
				?new ResponseEntity<String>("success",HttpStatus.OK)
				:  new ResponseEntity<String>("fail",HttpStatus.NOT_MODIFIED);
	}
}
