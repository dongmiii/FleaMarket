package com.fleamarket.util;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.fleamarket.domain.NoticeVO;

public class NoticeVoValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return NoticeVO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		
		NoticeVO nv = (NoticeVO) target;
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "title", "title Required", "제목을 입력해주세요");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "content", "content required", "내용을 입력해주세요");
		
	}
	
	
}	
