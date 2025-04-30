package com.fleamarket.etc;

import java.io.File;

import org.springframework.web.multipart.MultipartFile;

public interface ThumbnailMaker {
	
	public void makeThumbnail(File uploadPath, String uploadFileName, MultipartFile multipartFile);
	
}
