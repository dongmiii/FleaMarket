package com.fleamarket.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.fleamarket.domain.ReviewAttachVO;
import com.fleamarket.mapper.ReviewAttachMapper;

import lombok.extern.log4j.Log4j;

@Component
@Log4j
public class FileCheckTask {

	@Autowired
	private ReviewAttachMapper reviewAttachMapper;
	
	@Scheduled(cron="0 0 2 * * *")
	public void checkFiles() throws Exception {
		
		log.warn("=====================File check Task run=====================");
		log.warn(new Date());
		//get yesterdat file list in database 
		List<ReviewAttachVO> fileList = reviewAttachMapper.getOldFiles();
		
		//ready for check file in directory with database file list
		List<Path> fileListPaths = fileList.stream()
				.map(vo->Paths.get("C:\\uploadEx", vo.getUploadPath(), vo.getUuid(), "_", vo.getImageName()))
				.collect(Collectors.toList());
		
		//image file has thumbnail file so add thumbnail path on fileListPaths variable
		fileList.stream()
			.map(vo->Paths.get("C:\\uploadEx", vo.getUploadPath(), "\\s_", vo.getUuid(), "_", vo.getImageName()))
			.forEach(path->fileListPaths.add(path));
		
		fileList.stream()
			.map(vo->Paths.get("C:\\uploadEx", vo.getUploadPath(), "\\reviewDetail_", vo.getUuid(), "_", vo.getImageName()))
			.forEach(path->fileListPaths.add(path));
		
		fileList.stream()
			.map(vo->Paths.get("C:\\uploadEx", vo.getUploadPath(), "\\reviewMain_", vo.getUuid(), "_", vo.getImageName()))
			.forEach(path->fileListPaths.add(path));
		
		log.warn("=============================================================");
		
		fileListPaths.forEach(path->log.warn(path));
		
		File targetDir = Paths.get("C:\\uploadEx", getFolderYesterday()).toFile();
		
		File[] removeFiles = targetDir.listFiles(file->fileListPaths.contains(file.getPath())==false);
		log.warn("--------------------------------------------------------------");
		for(File file : removeFiles) {
			log.warn(file.getAbsolutePath());
			file.delete();
		}
	}
	
	private String getFolderYesterday() {
		SimpleDateFormat sdf  = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		String str = sdf.format(cal.getTime());
		return str.replace(str, File.separator);
	}
	
}
