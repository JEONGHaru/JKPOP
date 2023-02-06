package com.haru.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.haru.domain.AuthDTO;
import com.haru.domain.MemberDTO;
import com.haru.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user/")
@AllArgsConstructor
public class MemberController {

	private MemberService service;
	
	
	@GetMapping("login")
	public void loginForm(String error, String logout, Model model) {
		log.info("login----------------------------");
		log.info("login---------------------------- error : " + error);
		if(error != null) {
			model.addAttribute("result","IDもしくはPASSWORDが一致しません");
		}
		log.info("login---------------------------- logout : " + logout);
	}
	
	@GetMapping("register")
	public void registerForm() {
		log.info("UserController registerForm -------------------------- ");
		
	}
	
	@PostMapping("register")
	public String register(MemberDTO dto,RedirectAttributes rttr) {
		log.info("UserController------------------------ register");
		AuthDTO auth = new AuthDTO();
		auth.setAuth("ROLE_USER");
		auth.setUserId(dto.getUserId());
		List<AuthDTO> list = new ArrayList<AuthDTO>();
		list.add(auth);
		dto.setAuthList(list);
		log.info("UserController register--------------------------- MemberDTO : " + dto);
		
		int result = service.createMember(dto);
		
		if(result == 1 ) {
			rttr.addFlashAttribute("result","会員登録ありがとうございます。");
		}
		
		return "redirect:login";
	}
	
	@PostMapping("idCheck")
	@ResponseBody
	public String userIdChecked(String userId){

		log.info("MemberController--------------------------- userId : " + userId);
		
		String result = "";
		
		if( service.findByMemberid(userId) == 0) {
			result = "OK";
		}else {
			result = "NO";
		}
		
		return result; 
	}
	
	
	@GetMapping("forgotPassword")
	public void forgotPasswordForm() {
		log.info("MemberController forgotPassword -------------------------- ");
	}
	
	@PreAuthorize("isAnonymous()")
	@PostMapping("forgotPassword")
	public String forgotPassword(MemberDTO dto,RedirectAttributes rttr) {
		log.info("MemberController forgotPassword -------------------------- dto : " + dto);
		
		MemberDTO result = service.findByMemberPw(dto);
		log.info("MemberController forgotPassword -------------------------- result : " + result);
		if(result != null) {
			rttr.addFlashAttribute("result",dto.getEmail()+"に臨時パスワードを送信しました");
			return "redirect:/main";
		}
		return "redirect:forgotPassword";
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("changePw")
	public void changePasswordForm() {
		log.info("MemberController changePasswordForm --------------------------");
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("changePw")
	public String changeMemberPassword(MemberDTO dto, RedirectAttributes rttr) {
		log.info("MemberController changeMemberPassword -------------------------- MemberDTO : " + dto);
		if(service.changeMemberPw(dto) == 1) {
			rttr.addFlashAttribute("result","パスワードを変更しました");
		}
		
		return "redirect:/main";
	}
}
