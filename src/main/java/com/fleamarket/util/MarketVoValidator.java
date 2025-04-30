package com.fleamarket.util;


import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.fleamarket.domain.MarketVO;
import com.mchange.v2.cfg.PropertiesConfigSource.Parse;


public class MarketVoValidator implements Validator  {
	private static final String PHONENUMEXP = "^01(?:0|1|[6-9])(\\d{3}|\\d{4})(\\d{4})$"; //핸드폰 번호 표현식
	private static final String NAMEEXP = "^[가-힣]*$"; //한글만 표현식
	private static final String EMAILEXP = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$";
//	private static final String EMAILEXP = "^[a-zA-Z0-9]+@[a-zA-Z0-9]+$ or ^[_0-9a-zA-Z-]+@[0-9a-zA-Z-]+(.[_0-9a-zA-Z-]+)*$";
//	private static final String EMAILEXP = "^[a-zA-Z0-9]+@[a-zA-Z0-9]+$"; 
	private static final String DATEEXP = "^(19|20)\\d{2}/(0[1-9]|1[012])/(0[1-9]|[12][0-9]|3[0-1])$";
	
	
	private Pattern phoneNumPattern;
	private Pattern namePattern;
	private Pattern emailPattern;
	private Pattern datePattern;

	public MarketVoValidator() {
		this.phoneNumPattern = Pattern.compile(MarketVoValidator.PHONENUMEXP);
		this.namePattern = Pattern.compile(MarketVoValidator.NAMEEXP);
		this.emailPattern = Pattern.compile(MarketVoValidator.EMAILEXP);
		this.datePattern = Pattern.compile(MarketVoValidator.DATEEXP);
		
	}
	
	@Override
	public boolean supports(Class<?> clazz) {
		return MarketVO.class.isAssignableFrom(clazz);
	}
	
	
	//전화번호에 - 표시 없이하기
	//이메일 표시형식 
	//마켓 시작날짜가 종료날짜보다 빠르면 안됨
	//2019/01/01 형식으로 날짜 안되면 에러
	//이름에 특수문자 x 에러 
	//플리마켓 행사경험 x 면 에러
	//카데고리값이 아무것도 없으면 에러
	//주소없으면 에러
	//마켓소개 비어있으면 에러 
	@Override
	public void validate(Object target, Errors errors) {
		
		MarketVO mav = (MarketVO)target;
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mName","market Name required", "마켓이름을 입력해주세요");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "orgName", "Name required", "주최자 명을 입력해주세요");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mEmail", "email required", "이메일을 입력해주세요");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mPhone", "phonenum required", "연락처를 입력해주세요");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mInfo", "info required", "마켓소개를 입력해주세요");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mStartDate", "start date required", "마켓 시작일을 입력해주세요");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mLastDate", "last date required", "마켓 종료일을 입력해주세요");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mLocation", "location required", "마켓 위치를 입력해주세요");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mCategory", "category required", "카테고리를 선택해주세요");
		
		
		Matcher phoneNumMatcher = phoneNumPattern.matcher(mav.getMPhone());
//		Matcher marketnameMatcher = namePattern.matcher(mav.getMName());
		Matcher nameMatcher = namePattern.matcher(mav.getOrgName());
		Matcher emailMatcher = emailPattern.matcher(mav.getMEmail());
		
//		Matcher startdateMatcher = datePattern.matcher(mav.getMStartDate().toString());
//		Matcher lastdateMatcher = datePattern.matcher(mav.getMLastDate().toString());
		
		if(!phoneNumMatcher.matches()) {
			errors.rejectValue("mPhone", "bad form phonenum", "\'-\'없이 숫자로만 11자리를 입력해주세요");
		}
//		if(!marketnameMatcher.matches()) {
//			errors.rejectValue("mName", "bad form marketname","마켓이름은 한글 또는 영어만 가능합니다.");
//		}
		if(!nameMatcher.matches()) {
			errors.rejectValue("orgName", "bad form username","주최자 이름은 한글 또는 영어만 가능합니다.");
		}
		if(!emailMatcher.matches()) {
			errors.rejectValue("mEmail", "bad form email", "이메일 형식이 올바르지 않습니다. ex)market@example.com");
		}

		if(String.valueOf(mav.getMExp()).equals("X")) {
			errors.rejectValue("mExp", "bad form exp", "마켓 경험 유,무를 선택해주세요");
		}
		
//		if(!startdateMatcher.matches()) {
//			errors.rejectValue("mStartDate", "bad form date", "날짜형식이 알맞지 않습니다. ex)19/05/12");
//		}
//		
//		if(!lastdateMatcher.matches()) {
//			errors.rejectValue("mLastDate", "bad form date", "날짜형식이 알맞지 않습니다. ex)19/05/12");
//		}
		
		int compare = mav.getMStartDate().compareTo(mav.getMLastDate());
		
		if(compare>0) {
			errors.rejectValue("mStartDate", "not match date","시작일이 종료일보다 늦습니다.");
		}
		
	}
}




















