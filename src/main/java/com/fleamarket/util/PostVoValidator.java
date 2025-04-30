package com.fleamarket.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.fleamarket.domain.MemberVO;
import com.fleamarket.domain.ReviewVO;

public class PostVoValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return ReviewVO.class.isAssignableFrom(clazz);
	}

	// 마켓 선택이 되어있는지
	// 별점 선택이 되어있는지 X면 선택하라고 안내
	// 제목,내용 비어있으면
	@Override
	public void validate(Object target, Errors errors) {

		ReviewVO rv = (ReviewVO) target;
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "title", "title Required", "제목을 입력해주세요");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "content", "content required", "내용을 입력해주세요");

		if (String.valueOf(rv.getMno()).equals("X")) {
			errors.rejectValue("Mno", "bad Mno", "마켓을 선택하세요");
		}

		if (String.valueOf(rv.getMLikes()).equals("X")) {
			errors.rejectValue("MLikes", "bad MLikes", "평점을 남겨주세요");
		}
	}
}



















