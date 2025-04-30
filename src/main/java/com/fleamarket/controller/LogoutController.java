package com.fleamarket.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class LogoutController {

	@PreAuthorize("isAuthenticated()")
	@GetMapping("/logout/form")
	public void logoutGET() {
		log.info("custom logout");
	}
	
	
	@PostMapping("/customLogout")
	public void logoutPost() {
		log.info("post custom logout");
	}
}
