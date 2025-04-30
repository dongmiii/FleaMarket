package com.fleamarket.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fleamarket.domain.MemberVO;
import com.fleamarket.service.MemberService;
import com.fleamarket.util.MemberVoValidator;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MemberPageController {
	
	@Autowired
	private MemberService memberService;
	
	private MemberVO member;
	
	@GetMapping("/member/mypage")
	@PreAuthorize("isAuthenticated()")
	public void myPage(Model model, Principal principal) {
		log.info(principal.getName());
		this.member = memberService.getMember(principal.getName());
		model.addAttribute("member", member);
	}
	
	@GetMapping("/member/page")
	@PreAuthorize("isAuthenticated() AND hasAnyRole('ROLE_MASTER')")
	public String memberPageForMaster(Model model, String userid) {
		//log.info(principal.getName());
		this.member = memberService.getMember(userid);
		log.info("member: " + member); 
		model.addAttribute("member", member);
		return "member/mypage";
	}
	
	//마스터가 변경 가능하도록 바꿔줘야함
	@PostMapping("/member/modify")
	@PreAuthorize("principal.username == #userid OR hasAnyRole('ROLE_MASTER')")
	public String modifyMember(MemberVO memberVO, Errors errors, RedirectAttributes rttr, Model model, String userid) {
		
		log.info("modifyMember()");
		new MemberVoValidator().validate(memberVO, errors);
		if(errors.hasErrors()) {
			model.addAttribute("member", member);
			return "member/mypage";
		}
		memberService.updateMember(memberVO);
		rttr.addFlashAttribute("result", "success");
		return "redirect:/";
	}
	
	@PostMapping("/member/withdrawal")
	@PreAuthorize("principal.username == #userid OR hasAnyRole('ROLE_MASTER')")
	public String withdrawalMember(MemberVO memberVO, RedirectAttributes rttr, String userid) {
		log.info("withdrawalMember()");
		memberService.removeMember(memberVO.getUserid());
		rttr.addFlashAttribute("result", "success");
		return "redirect:/";
	}
	

	@PreAuthorize("hasAnyRole('ROLE_MASTER') AND isAuthenticated()")
	@DeleteMapping(value="/manage/member/remove/{userid}", produces= {MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public ResponseEntity<String> withdrawlMember(@PathVariable("userid")String userId){
		if(memberService.removeMember(userId)) {
			return new ResponseEntity<>("remove success", HttpStatus.OK);
		}
		return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}





















