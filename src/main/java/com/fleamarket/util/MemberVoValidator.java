package com.fleamarket.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.fleamarket.domain.MemberVO;

//회원가입폼에서 입력한 정보들의 검증 클래스
public class MemberVoValidator implements Validator {
	
	private static final String PHONENUMEXP = "^01(?:0|1|[6-9])(\\d{3}|\\d{4})(\\d{4})$"; //핸드폰 번호 표현식
	private static final String NAMEEXP = "^[가-힣]*$"; //한글만 표현식
	private static final String IDENTITYNUMEXP = "^(?:[0-9]{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[1,2][0-9]|3[0,1]))$"; //주민번호 앞자리 표현식

	private Pattern phoneNumPattern;
	private Pattern namePattern;
	private Pattern idenPattern;

	public MemberVoValidator() {
		this.phoneNumPattern = Pattern.compile(MemberVoValidator.PHONENUMEXP);
		this.namePattern = Pattern.compile(MemberVoValidator.NAMEEXP);
		this.idenPattern = Pattern.compile(MemberVoValidator.IDENTITYNUMEXP);
	}
	
	@Override
	public boolean supports(Class<?> clazz) {
		return MemberVO.class.isAssignableFrom(clazz);
	}
	
	
	//아이디, 1차비번, 2차비번, 이름, 성별, 주민번호 앞자리, 연락처
	//1,2차 비번 일치 확인--(완료)
	//아이디 중복확인--(완료)
	//핸드폰 번호 확인(숫자로만(11자리))--(완료)
	//이름에 숫자 들어가면 안됌--(완료)
	//성별 남,여 체크했는지 확인--(완료)
	//주민번호 숫자만(6자리)--(완료)
	//아이디랑 비번 같으면 안됌
	@Override
	public void validate(Object target, Errors errors) {
		
		MemberVO mv = (MemberVO)target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "userid","idRequired", "id를 입력해주세요"); //not null
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "userpw", "password required", "비밀번호를 입력해주세요");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "confirmPw", "second password required", "2차 비밀번호 입력해주세요");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "userName", "name required", "이름을 입력해주세요");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "idenNum", "idennum required", "주민번호(앞6자리)를 입력해주세요");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "phoneNum", "phonenum required", "연락처(핸드폰번호)를 입력해주세요");
		
		if(mv.getUserid().equals(mv.getUserpw())) {
			errors.rejectValue("userpw","not equals id with password", "아이디와 비밀번호가 같습니다. 다르게 해주세요");
		}
		
		if( mv.getUserpw() != null && !(mv.getUserpw().trim().isEmpty())) {
			if(!mv.getUserpw().equals(mv.getConfirmPw())) {
				errors.rejectValue("confirmPw", "not match password","1,2차 비밀번호가 서로 일치하지않습니다.");
			}
		}
		Matcher phoneNumMatcher = phoneNumPattern.matcher(mv.getPhoneNum());
		Matcher nameMatcher = namePattern.matcher(mv.getUserName());
		Matcher idenMatcher = idenPattern.matcher(mv.getIdenNum());
		
		if(!phoneNumMatcher.matches()) {
			errors.rejectValue("phoneNum", "bad form phonenum", "\'-\'없이 숫자로만 11자리를 입력해주세요");
		}
		if(!nameMatcher.matches()) {
			errors.rejectValue("userName", "bad form username","이름은 한글만 가능합니다.");
		}
		if(!idenMatcher.matches()) {
			errors.rejectValue("idenNum", "bad form idennum", "올바르지 않습니다.(숫자6자리)");
		}

		if(String.valueOf(mv.getGender()).equals("X")) {
			errors.rejectValue("gender", "bad form gender", "남 혹은 여 선택해주세요");
		}
			
	}
}




























