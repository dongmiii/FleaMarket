package com.fleamarket.etc;

import java.io.File;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.fleamarket.common.ThnSize;

import net.coobird.thumbnailator.Thumbnailator;

public class ItemThnMaker implements ThumbnailMaker {
	
	private File[] uploadFileArr;
	private Map<Integer,ThnSize<Integer>> sizeList;

	@Override
	public void makeThumbnail(File uploadPath, String uploadFileName, MultipartFile multipartFile) {
		
		this.uploadFileArr = new File[] {
				new File(uploadPath, "s_"+uploadFileName),
				new File(uploadPath, "itemDetail_"+uploadFileName)	
		};
		
		//�씤�뜳�뒪 �닚�꽌 �젙�빐�졇 �엳�쓬
		this.sizeList = new HashMap<>();
		sizeList.put(0,new ThnSize<Integer>(100,100)); //s_
		sizeList.put(1,new ThnSize<Integer>(300,350)); //itemDetail_
		
		try {
			FileOutputStream thumbnailFile = null;
			for(int i = 0; i<uploadFileArr.length; i++) {
				thumbnailFile = new FileOutputStream(uploadFileArr[i]);
				Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnailFile, 
						sizeList.get(i).getWidth(), sizeList.get(i).getHeight()); //�씠誘몄� �겕湲곗꽕�젙
			}
			thumbnailFile.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}

}
