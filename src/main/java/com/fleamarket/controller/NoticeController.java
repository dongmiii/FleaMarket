package com.fleamarket.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.fleamarket.domain.Criteria;
import com.fleamarket.domain.NoticePageDTO;
import com.fleamarket.domain.NoticeVO;
import com.fleamarket.service.NoticeService;
import com.fleamarket.util.NoticeVoValidator;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class NoticeController {

	@Autowired
	private NoticeService noticeService;
	
	@GetMapping("/notice/notice")
	public void noticePage(Criteria cri , Model model) { // 게시글 리스트
		log.info("INIT NOTICE PAGE");
		// List<NoticeVO> noticeList = noticeService.readNoticeList();
		List<NoticeVO> noticeList = noticeService.getList(cri);
		model.addAttribute("notice", noticeList);
		model.addAttribute("pageMaker" , new NoticePageDTO(cri, noticeService.getTotal(cri)));
		log.info("INIT NOTICE PAGE2");
	}
	
	@GetMapping("/notice/get")
	public void noticeContentPage(Model model, HttpServletRequest request , @ModelAttribute("cri") Criteria cri) { // 게시글 상세
		log.info("/notice/get");
		int no = Integer.parseInt(request.getParameter("no"));
		NoticeVO noticeContent = noticeService.readNoticeContent(no);
		noticeService.countNotice(no);
		model.addAttribute("notice", noticeContent);
		
	}
	
	@GetMapping("/notice/form")
	public void writeNoticePage(Model model, HttpServletRequest request) {
		if(request.getParameter("no") != null && request.getParameter("no") != "") { // no값이 있을때
			int no = Integer.parseInt(request.getParameter("no"));
			NoticeVO noticeContent = noticeService.readNoticeContent(no);
			model.addAttribute("notice", noticeContent);
		}
	}
	
	@PostMapping("/notice/write")
	public String writeNoticeAction(NoticeVO noticeVO, Errors errors, Model model) {
		log.info("noticeVo : >> " + noticeVO.toString());
		new NoticeVoValidator().validate(noticeVO, errors);
		if(errors.hasErrors()) {
			return "notice/form";
		}
		boolean writeNotice = noticeService.insertNotice(noticeVO);
		
		if(writeNotice) {
			return "redirect:/notice/notice";
		}else {
			return "notice/form";
		}
	}
	
	@PostMapping("/notice/modify")
	public String modifyNotice(NoticeVO noticeVO, Errors errors, Model model , @ModelAttribute("cri") Criteria cri) {
		
		new NoticeVoValidator().validate(noticeVO, errors);
		if(errors.hasErrors()) {
			return "notice/form";
		}
		boolean modifyNotice = noticeService.updateNotice(noticeVO);
		model.addAttribute("pageNum" , cri.getPageNum());
		model.addAttribute("amount" , cri.getAmount());
		if(modifyNotice) {
			return "redirect:/notice/notice";
		}else {
			return "notice/form";
		}

	}
	
	
	@GetMapping("/notice/delete")
	public String deleteNotice(HttpServletRequest request , Model model , @ModelAttribute("cri") Criteria cri) {
		int no = Integer.parseInt(request.getParameter("no"));
		boolean deleteNotice = noticeService.deleteNotice(no);
		model.addAttribute("pageNum" , cri.getPageNum());
		model.addAttribute("amount" , cri.getAmount());
		return "redirect:/notice/notice";
	}
	
	
}
