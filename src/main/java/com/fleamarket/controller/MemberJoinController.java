package com.fleamarket.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fleamarket.domain.MemberVO;
import com.fleamarket.service.MemberService;
import com.fleamarket.util.MemberVoValidator;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MemberJoinController {

	@Autowired
	private MemberService memberService;

	public void setMemberService(MemberService memberService) {
		this.memberService = memberService;
	}

	@GetMapping("/join/form")
	public void showJoinForm() {
		// /join/form.jsp 화면을 보여줌
	}
	
	@PostMapping("/join/joinMember")
	public String registMember(MemberVO memberVO, Errors errors, Model model, RedirectAttributes rttr) {
		log.info("registMember()");
		new MemberVoValidator().validate(memberVO, errors);
		if(errors.hasErrors()) {
			
			log.info("input password:" + errors.getFieldValue("userpw"));
			log.info("input confirmPw:" + errors.getFieldValue("confirmPw"));
			log.info("input userName:" + errors.getFieldValue("userName"));
			log.info("input gender:" + errors.getFieldValue("gender"));
			log.info("input idenNum:" + errors.getFieldValue("idenNum"));
			log.info("input phoneNum:" + errors.getFieldValue("phoneNum"));
			return "/join/form"; //redirect: 호출시 Errors객체가 전달이 안되는 것 같음
		}
		memberService.joinMember(memberVO);
		rttr.addFlashAttribute("result", "success");
		return "redirect:/";
	}
	
	@PostMapping(value="/join/idDuplicateCheck", produces= MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<Object,Object> checkDuplicateId(@RequestBody String inputId){
		log.info("checkDuplicateId()");
		Integer count = memberService.checkDuplicateId(inputId);
		log.info("input: " + inputId);
		log.info("checkDuplicateId() count: " + count);
		Map<Object,Object> map = new HashMap<>();
		map.put("count",count);
		return map;
	}
}





















