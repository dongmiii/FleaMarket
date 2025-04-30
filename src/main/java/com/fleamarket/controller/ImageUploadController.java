package com.fleamarket.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fleamarket.domain.AttachFileDTO;
import com.fleamarket.etc.ThumbnailMaker;
import com.fleamarket.etc.ThumbnailMakerFactory;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class ImageUploadController {
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value="/uploadAjaxAction", produces= MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile, String sort) {
		
		log.info("update ajax post.............");
		log.info("sort: " + sort);
		
		
		List<AttachFileDTO> uploadFileList = new ArrayList<>();
		String uploadFolder = "C:\\uploadEx";
		String uploadFolderPath = getFolderName();
		
		//make folder--------------------
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		log.info("upload path: " + uploadPath);
		
		if(uploadPath.exists() == false) { //폴더 없으면 만들어 주고
			uploadPath.mkdirs();
		}
		
		for(MultipartFile multipartFile : uploadFile) {
			//logging on server
			log.info("--------------------------------");
			log.info("upload File Name: " + multipartFile.getOriginalFilename());
			log.info("upload File Size: " + multipartFile.getSize());
			
			AttachFileDTO dto = new AttachFileDTO();
			String uploadFileName = multipartFile.getOriginalFilename();
			
			dto.setFileName(uploadFileName);
			
			//IE has file path, 파일명만 가져오기 위한 작업
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			
			//업로드 파일 이름의 중복방지를 위한 UUID생성과 파일이름과 결합
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName; //(원본)원래의 파일과 구분할 수 있게 _로 연결
			
			File saveFile = new File(uploadPath, uploadFileName);
			
			try { 
				multipartFile.transferTo(saveFile); //원본 서버 폴더에 업로드
				
				dto.setUuid(uuid.toString());
				dto.setUploadPath(uploadFolderPath);
				
				//check image type file
				if(checkImageType(saveFile)) {
					//이미지 타입이라면 섬네일을 생성하도록 수정
					//후기냐, 마켓이냐, 아이템 이미지냐 각 화면에 필요한 썸네일이 다양하게 필요하니 각각 이미지파일이름 앞에 이를 구별하기 위한 문자열을 정리해서 붙혀야한다.
					
					//썸네일이미지가 필요한 페이지에 알맞은 크기의 썸네일 이미지들이 여러개 필요함
					//후기 페이지: 리스트에 보여줄 대표이미지 하나, 상세페이지에서 보여줄 이미지들
					//s_(100x100) : 이미지 업로드한후 어떤 이미지를 업로드 했는지를 보여줄 때  이미지
					//reviewMain_(270x297) : 후기리스트에서 보여줄 메인 이미지
					//reviewDetail_(750x375) : 후기작성하고 후기상세페이지에서 보여줄 썸네일보다는 큰 이미지
					//marketMain_(588x406) : 메인페이지에 보여줄 마켓 대표이미지
					//marketDetail_(750x375) : 마켓 상세 보기에서 보여줄 이미지
					//marketItem_() : 각 마켓에서 판매될 이미지(각 아이템들의 크기가 정해져 있어야 할듯(gallary페이지의 사진정보 참조해서))
					//marketListMain_(270x297) : 마켓 모아보기 리스트에서 보여줄 마켓 이미지
					ThumbnailMakerFactory thnfactory = new ThumbnailMakerFactory();
					ThumbnailMaker maker = thnfactory.createMaker(sort);
					maker.makeThumbnail(uploadPath, uploadFileName, multipartFile);
					dto.setImage(true);
				}
				uploadFileList.add(dto);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return new ResponseEntity<>(uploadFileList, HttpStatus.OK);
	}
	
//	@PreAuthorize("isAuthenticated()")
	@GetMapping(value="/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		
		log.info("fileName: " + fileName);
		
		if(fileName == null || fileName.isEmpty() || fileName.length() == 0) {
			return null;
		}
		
		File file = new File("C:\\uploadEx\\" + fileName);
		log.info("file: " + file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		}catch(IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value="/deleteMarketFile", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<String> deleteMarketFile(String fileName, String type, String sort){
		//이미지 파일은 썸네일이미지와 일반이미지 모두 삭제해야함
		
		log.info("deleteFile: " + fileName);
		File file = null;
		
		try {
			//일반 파일인 경우 삭제, 이미지의 썸네일파일 삭제
			file = new File("C:\\uploadEx\\" + URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			if(type.equals("image")) { //이미지원본파일 삭제
				String originFileName = file.getAbsolutePath().replace("s_", "");
				String detailFileName=null;
				if(sort.equals("market")) {
					detailFileName = file.getAbsolutePath().replace("s_", "marketDetail_");
					String mainFileName = file.getAbsolutePath().replace("s_", "marketMain_");
					file = new File(mainFileName);
					file.delete(); //리뷰 리스트페이지용 섬네일 삭제
				}else if(sort.equals("item")) {
					detailFileName = file.getAbsolutePath().replace("s_", "itemDetail_");
				}
				log.info("deleted originImageName: " + originFileName);
				file = new File(originFileName);
				file.delete(); //원본파일 삭제
				file = new File(detailFileName);
				file.delete(); //리뷰 상세페이지용 섬네일 삭제
			}
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<>("해당 이미지 업로드 취소", HttpStatus.OK);
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value="/deleteFile", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type){
		//이미지 파일은 썸네일이미지와 일반이미지 모두 삭제해야함
		
		log.info("deleteFile: " + fileName);
		File file = null;
		
		try {
			//일반 파일인 경우 삭제, 이미지의 썸네일파일 삭제
			file = new File("C:\\uploadEx\\" + URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			if(type.equals("image")) { //이미지원본파일 삭제
				String originFileName = file.getAbsolutePath().replace("s_", "");
				String detailFileName = file.getAbsolutePath().replace("s_", "reviewDetail_");
				String mainFileName = file.getAbsolutePath().replace("s_", "reviewMain_");
				log.info("deleted originImageName: " + originFileName);
				file = new File(originFileName);
				file.delete(); //원본파일 삭제
				file = new File(detailFileName);
				file.delete(); //리뷰 상세페이지용 섬네일 삭제
				file = new File(mainFileName);
				file.delete(); //리뷰 리스트페이지용 섬네일 삭제
			}
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<>("해당 이미지 업로드 취소", HttpStatus.OK);
	}
	
	
	private String getFolderName() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date todayDate = new Date();
		String str = sdf.format(todayDate);
		return str.replace("-", File.separator); //시스템마다 다르기 때문에
	}
	
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			if(contentType.startsWith("image")) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
}
