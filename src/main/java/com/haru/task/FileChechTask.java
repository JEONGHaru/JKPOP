package com.haru.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.haru.domain.BoardFileDTO;
import com.haru.mapper.BoardFileMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Component
@Log4j
public class FileChechTask {

	@Setter(onMethod_ = @Autowired)
	private BoardFileMapper fileMapper;
	
//	@Scheduled(cron="0 * * * * *")
//	public void checkFiles() throws Exception{
//		
//		log.info("FIle Check Task start-------------");
//		
//		List<BoardFileDTO> fileList = fileMapper.getOldFiles();
//		
//		List<Path> fileListPaths = fileList.stream()
//				.map(dto -> Paths.get("/Users/jeong-gwang-yeong/Desktop/upload/tmp/images",dto.getUploadPath(),dto.getUuid()+"_"+dto.getFileName()))
//				.collect(Collectors.toList());
//		
//		fileList.stream().filter(dto -> dto.isFileType() ==  true)
//		.map(dto ->Paths.get("/Users/jeong-gwang-yeong/Desktop/upload/tmp/images",dto.getUploadPath(),"s_"+dto.getUuid()+"_"+dto.getFileName()))
//		.forEach(p -> fileListPaths.add(p));
//		
//		fileListPaths.forEach(p -> log.info(p));
//		
//		File targetDir = Paths.get("/Users/jeong-gwang-yeong/Desktop/upload/tmp/images",getFolderYesterDay()).toFile();
//		File[] deleteFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);
//		
//		for(File file : deleteFiles) {
//			log.info(file.getAbsolutePath());
//			file.delete();
//		}
//	}
	
	private String getFolderYesterDay() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		String str = sdf.format(cal.getTime());
		
		return str.replace("-", File.separator);
	}
	
}
