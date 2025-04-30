package com.fleamarket.etc;

import java.io.File;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.fleamarket.common.ThnSize;

import net.coobird.thumbnailator.Thumbnailator;
import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.name.Rename;

public class ReviewThnMaker implements ThumbnailMaker {

	//s_(100x100) : 이미지 업로드한후 어떤 이미지를 업로드 했는지를 보여줄 때  이미지
		//reviewMain_(270x297) : 후기리스트에서 보여줄 메인 이미지
		//reviewDetail_(750x375) : 후기작성하고 후기상세페이지에서 보여줄 썸네일보다는 큰 이미지(여러장 있을 수도 있고 없을 수도 있다.)
		//marketMain_(588x406) : 메인페이지에 보여줄 마켓 대표이미지
		//marketDetail_(750x375) : 마켓 상세 보기에서 보여줄 이미지
		//marketItem_() : 각 마켓에서 판매될 이미지(각 아이템들의 크기가 정해져 있어야 할듯(gallary페이지의 사진정보 참조해서))
		//marketListMain_(270x297) : 마켓 모아보기 리스트에서 보여줄 마켓 이미지
	
	private File[] uploadFileArr;
	private Map<Integer,ThnSize<Integer>> sizeList;
	
	
	@Override
	public void makeThumbnail(File uploadPath, String uploadFileName, MultipartFile multipartFile) {
		
		this.uploadFileArr = new File[] {
				new File(uploadPath, "s_"+uploadFileName),
				new File(uploadPath, "reviewMain_"+uploadFileName),
				new File(uploadPath, "reviewDetail_"+uploadFileName)	
		};
		
		//인덱스 순서 정해져 있음
		this.sizeList = new HashMap<>();
		sizeList.put(0,new ThnSize<Integer>(100,100));
		sizeList.put(1,new ThnSize<Integer>(270,297));
		sizeList.put(2,new ThnSize<Integer>(750,375));
		
		try {
			FileOutputStream thumbnailFile = null;
			for(int i = 0; i<uploadFileArr.length; i++) {
				thumbnailFile = new FileOutputStream(uploadFileArr[i]);
				Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnailFile, 
						sizeList.get(i).getWidth(), sizeList.get(i).getHeight()); //이미지 크기설정
			}
			thumbnailFile.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}



