package com.haru.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.haru.domain.AlbumDTO;
import com.haru.domain.AlbumFileDTO;
import com.haru.domain.UploadFileDTO;
import com.haru.service.AlbumService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@RestController
@Log4j
public class UploadController {

	@Setter(onMethod_ = @Autowired)
	private AlbumService albumService;
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value="uploadAjaxAction" ,produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<UploadFileDTO>> uploadAjax(MultipartFile[] uploadFile) throws Exception{
		String uploadFolder = "/Users/jeong-gwang-yeong/Desktop/upload/tmp/images";
		String uploadFolderPath = getFolder();
		log.info("uploadAjax POST----------------------------");
		List<UploadFileDTO> list = new ArrayList<UploadFileDTO>();
		
		File uploadPath = new File(uploadFolder,getFolder());
		if(!uploadPath.exists()) uploadPath.mkdirs();
		
		for (MultipartFile multipartFile : uploadFile) {
			UploadFileDTO dto = new UploadFileDTO();
			String fileName = multipartFile.getOriginalFilename();
			UUID uuid = UUID.randomUUID();
			String uploadFileName = uuid.toString() + "_" + fileName;
			//저장 되는 파일명
			File saveFile = new File(uploadPath,uploadFileName);
			multipartFile.transferTo(saveFile);
			dto.setUploadPath(uploadFolderPath);
			dto.setFileName(fileName);
			dto.setUuid(uuid.toString());
			log.info("UploadFileDTO==================== : " + dto);
			
			if(checkImageType(saveFile)) {
				dto.setImage(true);
				FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath,"s_"+uploadFileName));
				Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
				thumbnail.close();
			}
			list.add(dto);
			
			
		}
		return new ResponseEntity<List<UploadFileDTO>>(list,HttpStatus.OK); 
	}
	
	@GetMapping("/display")
	public ResponseEntity<byte[]> getFile(String fileName) throws Exception{
		ResponseEntity<byte[]> result = null;
		String uploadFolder = "/Users/jeong-gwang-yeong/Desktop/upload/tmp/images";
		log.info("display fileName================" + fileName);
		File file = new File(uploadFolder,fileName);
		
		HttpHeaders header = new HttpHeaders();
		
		header.add("content-type",Files.probeContentType(file.toPath()));
		
		result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file),header,HttpStatus.OK);
		
		return result;
	}
	@GetMapping("/randomDisplay")
	public ResponseEntity<byte[]> getFile() throws Exception{
		ResponseEntity<byte[]> result = null;
		String uploadFolder = "/Users/jeong-gwang-yeong/Desktop/upload/album";
		String imagePath = albumService.getRandomImage();
		File file = new File(uploadFolder,imagePath);
		
		HttpHeaders header = new HttpHeaders();
		
		header.add("content-type",Files.probeContentType(file.toPath()));
		
		result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file),header,HttpStatus.OK);
		
		return result;
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName,String type)throws Exception {
		String uploadFolder = "/Users/jeong-gwang-yeong/Desktop/upload/tmp/images";
		log.info("deleteFile FileName ------------------ : " + fileName);
		log.info("deleteFile type ------------------ : " + type);
		
		File file = new File(uploadFolder+File.separator+URLDecoder.decode(fileName,"UTF-8"));
		
		file.delete();
		
		if(type.equals("image")) {
			//String largeFileName = file.getAbsolutePath().replace("s_", "");
			String largeFileName = file.getAbsolutePath();
			int pos = largeFileName.lastIndexOf(File.separator);
			largeFileName = largeFileName.substring(0,pos) + largeFileName.substring(pos).replaceFirst("s_","") ;
			new File(largeFileName).delete();
		}
		
		return new ResponseEntity<String>("success deleted",HttpStatus.OK);
	}
	
	@GetMapping(value="/download",produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName) throws Exception{
		String uploadFolder = "/Users/jeong-gwang-yeong/Desktop/upload/tmp/images";
		ResponseEntity<Resource> entity = null;
		log.info("download File ------------------ fileName : " + fileName);
	
		Resource resource = new FileSystemResource(uploadFolder+File.separator+fileName);
		
		if(!resource.exists()) return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		
		String resourceName = resource.getFilename();
		resourceName = resourceName.substring(resourceName.indexOf("_")+1);
		HttpHeaders headers = new HttpHeaders();
		String downloadName = null;
		
		//Browser -- IE
		if(userAgent.contains("Trident")) downloadName = URLEncoder.encode(resourceName,"UTF-8").replaceAll("\\+"," ");
		//Browser -- Edge(window)
		else if(userAgent.contains("Edge"))  downloadName = URLEncoder.encode(resourceName,"UTF-8");
		else downloadName = new String(resourceName.getBytes("UTF-8"),"ISO-8859-1");
		
		headers.add("content-disposition","attachment; filename="+downloadName);
		log.info("headers ----------------- : "+headers);
		entity = new ResponseEntity<Resource>(resource,headers,HttpStatus.OK);
		log.info("entity----------------- : "+entity);
		
		return entity;
	}
	
	
	
	public ResponseEntity<byte[]> getAlbumFile(String fileName) throws Exception{
		ResponseEntity<byte[]> result = null;
		String uploadFolder = "/Users/jeong-gwang-yeong/Desktop/upload/album";
		log.info("display fileName================" + fileName);
		File file = new File(uploadFolder,fileName);
		
		HttpHeaders header = new HttpHeaders();
		
		header.add("content-type",Files.probeContentType(file.toPath()));
		
		result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file),header,HttpStatus.OK);
		
		return result;
		
	}
	
	//image check
	private boolean checkImageType(File file) throws Exception {
		
		String contentType = Files.probeContentType(file.toPath());
		log.info("contentType  -------------- : "+contentType);
		
		return contentType.startsWith("image");
	}
	//日付のフォルダーを作成 - mappingとは関係ない
	private String getFolder() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		//오늘 날짜 객체 생성
		Date date = new Date();
		
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
		};
}
