package ppeonfun.controller.user.supporter;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import ppeonfun.dto.Favorite;
import ppeonfun.dto.Information;
import ppeonfun.dto.News;
import ppeonfun.dto.Supporter;
import ppeonfun.dto.SupporterJoin;
import ppeonfun.service.user.supporter.SupporterService;

@Controller("user.SupporterController")
public class SupporterController {
	
	private static final Logger logger = LoggerFactory.getLogger(SupporterController.class);
	
	@Autowired
	private SupporterService supporterService;
	
	
	@RequestMapping(value = "/supporter")
	public String supporter(
			Information info, Supporter supporter, SupporterJoin suJoin, Model model, 
			News news, HttpSession session) {
		
		//해당 프로젝트의 제목, 카테고리, 목표금액
		info = supporterService.projectInfo(info);
//		logger.info("제목, 카테고리, 목표금액 {}", info);
		
		//해당 프로젝트의 총 서포터 수 구하기
		int totalCount = supporterService.totalCount(supporter);
//		logger.info("총 서포터 수 {}명", totalCount);
		
		//해당 프로젝트 서포터 리스트
		List<SupporterJoin> list = supporterService.supporterList(suJoin);
//		logger.info("서포터 리스트 {}", list);
		
		//프로젝트 남은 일수 구하기
		int remaining_day = supporterService.remainDay(suJoin);
//		logger.info("남은 날짜 {}", remaining_day);
		
//		int achievement_rate = supporterService.achievementRate
		
		//프로젝트의 총 펀딩 액
		int total_amount = supporterService.amount(suJoin);
//		logger.info("총 펀딩 액 {}", total_amount);
		
		//새소식 개수
		int newsCount = supporterService.newsCount(news);
		
		//로그인 상태 확인 후 찜 작업 수행
		
		//찜 상태 조회
		Favorite favorite = new Favorite();
		favorite.setpNo(news.getpNo()); //프로젝트 번호
		favorite.setmNo(((Integer)session.getAttribute("mNo")).intValue()); //회원번호
		
		//찜 상태 확인
		boolean isFav = supporterService.isFav(favorite); 
		logger.info("찜 상태 확인 {}", isFav);
		
		model.addAttribute("totalCnt", totalCount);
		model.addAttribute("list", list);
		model.addAttribute("remainDay", remaining_day);
		model.addAttribute("totalAmount", total_amount);
		model.addAttribute("info", info);
		model.addAttribute("newsCnt", newsCount);
		
		model.addAttribute("isFav", isFav); //회원의 찜 상태 전달
		model.addAttribute("cntFav", supporterService.getTotalCntFavorite(favorite)); //총 좋아요 횟수
		
		return "/user/project/supporter";
		
	}
	
	
	@RequestMapping(value = "/supporter/favorite")
	public ModelAndView favorite(Favorite favorite, ModelAndView mav, HttpSession session) {
		
		//찜(하트)
		favorite.setmNo(((Integer)session.getAttribute("mNo")).intValue());
		boolean result = supporterService.favorite(favorite);
		
		//좋아요 수 조회
		int cnt = supporterService.getTotalCntFavorite(favorite);
		
		mav.addObject("result", result);
		mav.addObject("cnt", cnt);
		mav.setViewName("jsonView");
		
		return mav;
	}

}
