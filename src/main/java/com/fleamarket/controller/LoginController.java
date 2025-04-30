package com.fleamarket.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController {
	
	@GetMapping("/login/form")
	public void loginForm() {
		
	}
	
	//로그인 후에는 default로 "/"url로 이동한다.
}
