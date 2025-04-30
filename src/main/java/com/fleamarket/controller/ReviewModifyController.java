package com.fleamarket.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fleamarket.domain.MarketVO;
import com.fleamarket.domain.ReviewAttachVO;
import com.fleamarket.domain.ReviewVO;
import com.fleamarket.service.MarketService;
import com.fleamarket.service.ReviewService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class ReviewModifyController {
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private MarketService marketService;
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/review/modify")
	public void goReviewModifyForm(@RequestParam("reviewNo")long reviewNo, Model model) {
		ReviewVO vo = reviewService.getReview(reviewNo);
		model.addAttribute("review", vo);
		
		List<MarketVO> marketList = marketService.getMarketList(); //selectbox에 출력하기위한 마켓 리스트
		model.addAttribute("marketList", marketList);
	}
	
	@PreAuthorize("principal.username == #reviewVO.writer")
	@PostMapping("/review/modify")
	public String modifyReview(ReviewVO reviewVO, RedirectAttributes rttr) {
		log.info("modifyReview(ReviewVO reviewVO, RedirectAttributes rttr)");
		if(reviewService.updateReview(reviewVO)) {
			rttr.addFlashAttribute("result", "후기수정");
		}
		return "redirect:/review/list";
//		return "redirect:/board/list" + cri.getListLink();
	}
	
	@PreAuthorize("principal.username == #reviewVO.writer")
	@PostMapping("/review/remove")
	public String removeReview(ReviewVO reviewVO, RedirectAttributes rttr) {
		log.info("removeReview(ReviewVO reviewVO, RedirectAttributes rttr)");
		List<ReviewAttachVO> attachList = reviewVO.getAttachList();
		if(reviewService.removeReview(reviewVO.getReviewNo())) {
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "후기삭제");
		}
		return "redirect:/review/list";
	}
	
	private void deleteFiles(List<ReviewAttachVO> attachList) {
		
		if(attachList == null || attachList.size() == 0) {
			log.info("이미지 존재하지 않음");
			return;
		}
		
		log.info("=================DELETE ATTACH FILES===================");
		log.info(attachList);
		log.info("=======================================================");
		
		attachList.forEach(attach->{
			Path originalFile = Paths.get("C:\\uploadEx\\" + attach.getUploadPath() + "\\" + attach.getUuid() 
												+ "_" + attach.getImageName());
			try {
				Files.deleteIfExists(originalFile); //(존재시)원본 파일/이미지 폴더에서 삭제
				if(Files.probeContentType(originalFile).startsWith("image")) { //이미지라면 섬네일 삭제
					Path thumbnailFilePath = Paths.get("C:\\uploadEx\\" + attach.getUploadPath() + "\\s_" + attach.getUuid() 
												+ "_" + attach.getImageName());
					Files.delete(thumbnailFilePath);
					Path reviewDetailFilePath = Paths.get("C:\\uploadEx\\" + attach.getUploadPath() + "\\reviewDetail_" + attach.getUuid() 
												+ "_" + attach.getImageName());
					Files.delete(reviewDetailFilePath);
					Path reviewMainFilePath = Paths.get("C:\\uploadEx\\" + attach.getUploadPath() + "\\reviewMain_" + attach.getUuid() 
												+ "_" + attach.getImageName());
					Files.delete(reviewMainFilePath);
				}
			}catch(IOException e) {
				log.error("delete file error" + e.getMessage());
			}
		});
	}
}




























