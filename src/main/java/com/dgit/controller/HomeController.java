package com.dgit.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dgit.domain.PhotoVO;
import com.dgit.domain.UserVO;
import com.dgit.service.PhotoService;
import com.dgit.service.UserService;
import com.dgit.util.MediaUtils;
import com.dgit.util.UploadFileUtils;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private UserService service;
	
	@Autowired
	
	private PhotoService photoService;

	@Resource(name = "uploadPath")
	private String outUploadPath;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		logger.info("[home]");

		return "home";
	}

	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String login(String id, String pw, RedirectAttributes rttr) {
		logger.info("[login]");
		UserVO user = service.readWithpw(id, pw);

		if (user == null) {
			logger.info("[login] null");
			rttr.addFlashAttribute("fail", "ID나 PW를 확인해주세요");
			return "redirect:/";
		} else {
			logger.info("[login] not null");
			rttr.addAttribute("id", user.getId());
			return "redirect:photo";
		}
	}

	@ResponseBody
	@RequestMapping(value = "join", method = RequestMethod.POST)
	public ResponseEntity<String> joinPost(UserVO vo) {
		logger.info("[JoinPost]");
		ResponseEntity<String> entity = null;
		try {
			service.create(vo);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);

		} catch (Exception e) {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@ResponseBody
	@RequestMapping(value = "checkdWhihId", method = RequestMethod.GET)
	public ResponseEntity<String> checkdWhihId(String id, Model model) {
		ResponseEntity<String> entity = null;
		try {
			UserVO vo = service.readWithId(id);
			if (vo == null) {
				entity = new ResponseEntity<String>("success", HttpStatus.OK);
			} else {
				entity = new ResponseEntity<String>("fail", HttpStatus.OK);
			}
		} catch (Exception e) {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "photo")
	public String photo(String id, Model model) {
		logger.info("[photo]");

		return "photo";
	}

	@RequestMapping(value = "upload", method = RequestMethod.GET)
	public String uploadGet() {
		logger.info("[upload]");
		return "upload";
	}
	
	@RequestMapping(value = "upload", method = RequestMethod.POST)
	public String uploadPost(List<MultipartFile> files,String id){
		logger.info("[upload Post]");
		
		for(MultipartFile file : files){
			logger.info("[FileName] : " +file.getOriginalFilename());
		}
		
		try{
			if (files != null && files.get(0).getSize() > 0) {

				for (int i = 0; i < files.size(); i++) {
					String savedName = UploadFileUtils.uploadFile(outUploadPath, files.get(i).getOriginalFilename(),
							files.get(i).getBytes());
					photoService.insert(id, savedName);
				}
			}
		}catch(Exception e){
			
		}
		return "photo";
	}
	@ResponseBody
	@RequestMapping(value="photolist")
	public ResponseEntity<List<PhotoVO>> photolist(String id){
		ResponseEntity<List<PhotoVO>> entity = null;

		List<PhotoVO> list = photoService.selectByid(id);
		for(PhotoVO vo : list){
			logger.info(vo.toString());
		}
		entity = new ResponseEntity<List<PhotoVO>>(list,HttpStatus.OK);

		return entity;
	}
	@ResponseBody
	@RequestMapping(value = "displayFile", method = RequestMethod.GET)
	public ResponseEntity<byte[]> displayFile(String filename) {
		ResponseEntity<byte[]> entity = null;
		InputStream in = null;
		logger.info("[displayfile] " + filename);

		try {
			String formatName = filename.substring(filename.lastIndexOf(".") + 1);
			MediaType type = MediaUtils.getMediaType(formatName);
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(type);
			in = new FileInputStream(outUploadPath + filename);
			entity = new ResponseEntity<>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value="deleteFile",method=RequestMethod.GET)
	public ResponseEntity<String> deleteFile(String filename,String id){
		
		ResponseEntity<String> entity = null;
		logger.info("deleteFile : " + filename);
		try {
			System.gc(); //garbage
			
			String front =filename.substring(0,12);
			String end = filename.substring(14);
			File orignalFile = new File(outUploadPath+front+end);
			logger.info(orignalFile.getAbsolutePath());	
			logger.info("file : "+orignalFile.exists());
			boolean isFlag = orignalFile.delete();
			logger.info("flag:"+isFlag);
			orignalFile.delete();
			
			File file = new File(outUploadPath+filename);
			logger.info("file : "+file.exists());
			boolean isFlag1 = file.delete();
			logger.info("flag:"+isFlag1);
			photoService.delete(id, filename);
			entity = new ResponseEntity<>("Success",HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>("fail",HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	@RequestMapping(value="logout",method=RequestMethod.GET)
	public String logout(HttpSession session){
		session.invalidate();
		return "redirect:/";
	}
}
