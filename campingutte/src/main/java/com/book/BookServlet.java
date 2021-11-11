package com.book;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.SessionInfo;
import com.util.MyServlet;
import com.util.MyUtil;

@WebServlet("/book/*")
public class BookServlet extends MyServlet{
	private static final long serialVersionUID = 1L;

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String uri=req.getRequestURI();
		
		// URI에 따른 작업 구분
		if (uri.indexOf("campList.do") != -1) {
			// 캠핑장 리스트 (캠핑장 리스트 + 검색)
			campList(req,resp);
		} else if (uri.indexOf("campArticle.do") != -1) {
			// 캠핑장 글보기 (캠핑장 상세정보 + (x)객실리스트(x) )
			campArticle(req,resp);
		} else if (uri.indexOf("book.do") != -1) {
			// 객실 글보기 
			// + 예약정보 기입 (세부사항 작성) ==> bookSubmit에서 (book_ok.do)
			book(req, resp);
		} else if (uri.indexOf("book_ok.do") != -1) {
			// 예약정보 작성/ 완료
			bookSubmit(req, resp);
		} else if (uri.indexOf("confirm.do") != -1) {
			// 예약확인서 출력
			bookConfirm(req, resp);
		} else if (uri.indexOf("roomList.do") != -1) {
			// 객실리스트 (메인 글과 댓글 구분과 같은..?)
			roomList(req,resp);
		} else if (uri.indexOf("book1.do") != -1) {
			// bookForm(req, resp); // (X)
			// book 연결용 (나중에 삭제)
			forward(req, resp, "/WEB-INF/campingutte/book/book.jsp");
		}
		// + TODO: 댓글형태의 객실리스트 추가..
		// + 마이페이지 예약 취소/수정 추가..
	}
	
	/*
	Session
	(1) ID
	(2) NAME
	(3) (ROLL)
	(4) SrtDate 시작일
	(5) EndDate 종료일
	(6) Addr1 장소
	(7) People 인원
	(8) CampName 캠프장명
	*/
	
	protected void campList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 캠핑장 리스트 (캠핑장 리스트 + 검색)
		BookDAO dao = new BookDAO();
		MyUtil util = new MyUtil();
		
		String cp = req.getContextPath();
		
		// 세션객체. SrtDate 시작일, EndDate 종료일, Addr1 장소, People 인원, CampName 캠프장명
		HttpSession session = req.getSession();
		
		try {
			String page = req.getParameter("page");
			int current_page = 1;
			
			if (page != null) {
				current_page = Integer.parseInt(page);
			}
			
			// 검색
			// String condition = req.getParameter("condition");
				// condition 미사용
			String keywordSrtDate = req.getParameter("srtDate");
			String keywordEndDate = req.getParameter("endDate");
			String keywordAddr1 = req.getParameter("addr1");
			String keywordPeople = req.getParameter("people");
			String keywordCampName = req.getParameter("campName");
			
			if (keywordSrtDate == null) {
				keywordSrtDate = "";
			}
			if (keywordEndDate == null) {
				keywordEndDate = "";
			}
			if (keywordAddr1 == null) {
				keywordAddr1 = "";
			}
			if (keywordPeople == null) {
				keywordPeople = "";
			}
			if (keywordCampName == null) {
				keywordCampName = "";
			}
			
			
			// GET 방식 디코딩
			if (req.getMethod().equalsIgnoreCase("GET")) {
				keywordSrtDate = URLDecoder.decode(keywordSrtDate,"utf-8");
				keywordEndDate = URLDecoder.decode(keywordEndDate,"utf-8");
				keywordAddr1 = URLDecoder.decode(keywordAddr1,"utf-8");
				keywordPeople = URLDecoder.decode(keywordPeople,"utf-8"); // 필요없음.
				keywordCampName = URLDecoder.decode(keywordCampName,"utf-8");
			}
			
			// 세션에 저장할 내용: SrtDate, EndDate, Addr1, People, CampName
			SessionInfo info = (SessionInfo)session.getAttribute("member");
						// 세션에 member이라는 이름으로 저장
						// session.setAttribute("member", info);
			
			info.setSrtDate(keywordSrtDate);
			info.setEndDate(keywordEndDate);
			info.setAddr1(keywordAddr1);
			info.setPeople(keywordPeople);
			info.setCampName(keywordCampName);
			
			session.setAttribute("member", info);
			
			// 전체 캠핑장 개수
			int campCount;
			
			String [] keyword = 
				{keywordSrtDate,keywordEndDate,keywordAddr1,keywordPeople,keywordCampName};
			
			if (keywordSrtDate.length() == 0 
				&& keywordEndDate.length() == 0
				&& keywordAddr1.length() == 0
				&& keywordPeople.length() == 0
				&& keywordCampName.length() == 0) {
				campCount = dao.campCount();
			} else {
				campCount = dao.campCount(keyword);
			}
			
			// 전체 페이지 수
			int rows = 10;
			int total_page = util.pageCount(rows, campCount);
			
			if (current_page > total_page) {
				current_page = total_page;
			}
			
			int start = (current_page - 1) * rows + 1;
			int end = current_page * rows;
			
			// 캠핑장 게시물 가져오기
			List<CampSiteDTO> list = null;
			if (keywordSrtDate.length() == 0 
					&& keywordEndDate.length() == 0
					&& keywordAddr1.length() == 0
					&& keywordPeople.length() == 0
					&& keywordCampName.length() == 0) {
				list = dao.listCamp(start,end);
			} else {
				list = dao.listCamp(start,end,keyword);
			}
			
			// 리스트 글번호 만들기
			int listNum, n = 0;
			for (CampSiteDTO dto : list) {
				listNum = campCount - (start+n-1);
				dto.setListNum(listNum);
				n++;
			}
			
			String query = "";
			if (keywordSrtDate.length() != 0 || keywordEndDate.length() != 0) {
				query = "srtDate="+URLEncoder.encode(keyword[0], "utf-8")
					+"&endDate="+URLEncoder.encode(keyword[1], "utf-8");
				
				if (keyword[2].length() != 0) {
					query += "&addr1="+URLEncoder.encode(keyword[2], "utf-8");
				}
				if (keyword[3].length() != 0) {									
					query += "&people="+URLEncoder.encode(keyword[3], "utf-8");
				}
				if (keyword[4].length() != 0) {					
					query += "&campName="+URLEncoder.encode(keyword[4], "utf-8");
				}
			}
			
			// 페이징 처리
			String listUrl = cp + "/book/campList.do";
			String articleUrl = cp + "/book/campArticle.do?page=" + current_page;
			
			if (query.length() != 0) {
				listUrl += "?" + query;
				articleUrl += "&" + query;
			}
			String paging = util.paging(current_page, total_page, listUrl);
			
			// 포워딩할 JSP에 전달할 속성
			req.setAttribute("list", list);
			req.setAttribute("page", current_page);
			req.setAttribute("total_page", total_page);
			req.setAttribute("campCount", campCount);
			req.setAttribute("articleUrl", articleUrl);
			req.setAttribute("paging", paging);
			req.setAttribute("keyword", keyword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// JSP로 포워딩
		forward(req, resp, "/WEB-INF/campingutte/book/campList.jsp");
	}
	
	protected void campArticle(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 캠핑장 글보기 (캠핑장 상세정보 + 객실리스트(?) )
		// TODO: 객실리스트
		BookDAO dao = new BookDAO();
		MyUtil util = new MyUtil();
		
		String cp = req.getContextPath();
		String page = req.getParameter("page");
		
		String query = "page="+page;
		
		try {
			// campNo (읽어와야 함!)
			String campNo = req.getParameter("campNo");
			
			// String condition = req.getParameter("condition");
			String keywordSrtDate = req.getParameter("srtDate");
			String keywordEndDate = req.getParameter("endDate");
			String keywordAddr1 = req.getParameter("addr1");
			String keywordPeople = req.getParameter("people");
			String keywordCampName = req.getParameter("campName");
			
			keywordSrtDate = URLDecoder.decode(keywordSrtDate, "utf-8");
			keywordEndDate = URLDecoder.decode(keywordEndDate, "utf-8");
			keywordAddr1 = URLDecoder.decode(keywordAddr1, "utf-8");
			keywordPeople = URLDecoder.decode(keywordPeople, "utf-8");
			keywordCampName = URLDecoder.decode(keywordCampName, "utf-8");
			
			String [] keyword = 
				{keywordSrtDate,keywordEndDate,keywordAddr1,keywordPeople,keywordCampName};
			// String query = "";
			if (keywordSrtDate.length() != 0 || keywordEndDate.length() != 0) {
				query += "&srtDate="+URLEncoder.encode(keyword[0], "utf-8")
					+"&endDate="+URLEncoder.encode(keyword[1], "utf-8");
				
				if (keyword[2].length() != 0) {
					query += "&addr1="+URLEncoder.encode(keyword[2], "utf-8");
				}
				if (keyword[3].length() != 0) {									
					query += "&people="+URLEncoder.encode(keyword[3], "utf-8");
				}
				if (keyword[4].length() != 0) {					
					query += "&campName="+URLEncoder.encode(keyword[4], "utf-8");
				}
			}
			
			
			// 게시물 가져오기
			CampSiteDTO dto = dao.readCamp(campNo);
			if (dto == null) { // 게시글 없으면
				resp.sendRedirect(cp+"/book/campList.do"+query);
				return;
			}
			dto.setCampDetail(util.htmlSymbols(dto.getCampDetail()));
			
			// JSP로 전달할 속성
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("query", query);
			// 이전글,다음글 없음
			
			// 포워딩
			forward(req, resp, "/WEB-INF/campingutte/book/campArticle.jsp");
			return;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp + "/book/campList.do?" + query);
	}
	
	// AJAX - Text
	protected void roomList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 객실리스트 (??)
		// study4/bbs/BoardSerlet - listReply 참고 (메인에 댓글 형태)
		
		BookDAO dao = new BookDAO();
		MyUtil util = new MyUtil();
		
		try {
			// int num = Integer.parseInt(req.getParameter("num"));
			String campNo = req.getParameter("campNo");
			String roomPageNo = req.getParameter("roomPageNo");
			int current_page = 1;
			if (roomPageNo  != null) {
				current_page = Integer.parseInt(roomPageNo);
			}
			
			String keywordSrtDate = req.getParameter("srtDate");
			String keywordEndDate = req.getParameter("endDate");
			// String keywordAddr1 = req.getParameter("addr1");
			String keywordPeople = req.getParameter("people");
			// String keywordCampName = req.getParameter("campName");
			
			keywordSrtDate = URLDecoder.decode(keywordSrtDate, "utf-8");
			keywordEndDate = URLDecoder.decode(keywordEndDate, "utf-8");
			// keywordAddr1 = URLDecoder.decode(keywordAddr1, "utf-8");
			keywordPeople = URLDecoder.decode(keywordPeople, "utf-8");
			// keywordCampName = URLDecoder.decode(keywordCampName, "utf-8");
			
			String [] keyword = 
				{keywordSrtDate,keywordEndDate,keywordPeople}; // [0,1,2]
			
			
			int rows = 5;
			int roomTotal_page = 0;
			int roomCount = 0;
			
			roomCount = dao.roomCount(campNo, keyword);
			roomTotal_page = util.pageCount(rows, roomTotal_page);
			
			if (current_page > roomTotal_page) {
				current_page = roomTotal_page;
			}
			
			int start = (current_page-1) * rows + 1;
			int end = current_page * rows;
			
			List<RoomDTO> listRoom = dao.listRoom(campNo, keyword, start, end);
			
			for (RoomDTO dto : listRoom) {
				dto.setRoomDetail(dto.getRoomDetail().replaceAll("\n","<br>"));
			}
			
			String roomPaging = util.pagingMethod(current_page, roomTotal_page, "listPage");
			
			req.setAttribute("listRoom", listRoom);
			req.setAttribute("pageNo", current_page);
			req.setAttribute("roomCount", roomCount);
			req.setAttribute("roomTotal_page", roomTotal_page);
			req.setAttribute("roomPaging", roomPaging);
			
			forward(req,resp,"/WEB-INF/campingutte/bbs/roomList.jsp");
			// campArticle,
			// roomList 
			
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendError(405); //
	}
	
	protected void book(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 객실 글보기
		// + 예약정보 기입 (세부사항 작성) --> bookSubmit에서..
		// 예약정보 기입? (--> bookForm)
		// forward(req, resp, "/WEB-INF/campingutte/book/book.jsp");
		
		BookDAO dao = new BookDAO();
		MyUtil util = new MyUtil();
		
		String cp = req.getContextPath();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		
		
		String page = req.getParameter("page");
		String query = "page="+page;
		
		try {
			// roomNo (읽어와야 함!)
			String roomNo = req.getParameter("roomNo");
			
			// String condition = req.getParameter("condition");
			String keywordSrtDate = req.getParameter("srtDate");
			String keywordEndDate = req.getParameter("endDate");
			// String keywordAddr1 = req.getParameter("addr1");
			String keywordPeople = req.getParameter("people");
			// String keywordCampName = req.getParameter("campName");
			
			keywordSrtDate = URLDecoder.decode(keywordSrtDate, "utf-8");
			keywordEndDate = URLDecoder.decode(keywordEndDate, "utf-8");
			// keywordAddr1 = URLDecoder.decode(keywordAddr1, "utf-8");
			keywordPeople = URLDecoder.decode(keywordPeople, "utf-8");
			// keywordCampName = URLDecoder.decode(keywordCampName, "utf-8");
			
			String [] keyword = 
				{keywordSrtDate,keywordEndDate,keywordPeople}; // [0,1,2]
			
			if (keywordSrtDate.length() != 0 || keywordEndDate.length() != 0) {
				query += "&srtDate="+URLEncoder.encode(keyword[0], "utf-8")
					+"&endDate="+URLEncoder.encode(keyword[1], "utf-8");
				
				if (keyword[2].length() != 0) {
					query += "&people="+URLEncoder.encode(keyword[2], "utf-8");
				}
			}
			
			// 객실 게시물 가져오기
			RoomDTO dto = dao.readRoom(roomNo);
			
			if (dto == null) { // 객실 게시글 없으면
				resp.sendRedirect(cp+"/book/campArticle.do"+query);
				return;
			}
			
			info.setRoomNo(roomNo);
			
			session.setAttribute("member", info);
			
			dto.setRoomDetail(util.htmlSymbols(dto.getRoomDetail()));
			
			// JSP로 전달할 속성
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("query", query);
			
			// 이전글,다음글 없음
			
			// 포워딩
			forward(req, resp, "/WEB-INF/campingutte/book/book.jsp");
			return;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp + "/book/roomList.do?" + query);
	}
	
	/*
	protected void bookForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 예약정보 입력
		// 예약자명, 휴대폰번호, 이메일, 요청사항
		BookDAO dao = new BookDAO();
		MyUtil util = new MyUtil();
		
		// 글쓰기 폼 형태 필요 없음
	}
	*/
	
	protected void bookSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 예약정보 작성 완료 (저장) -- 예약완료 (예약확인서 출력으로 넘어가기)
		BookDAO dao = new BookDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String cp = req.getContextPath();
		
		if (req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp+"/book/roomList.do"); // 객실 리스트로 리다이렉트
			return;
		}
		
		// book_seq
		try {
			BookDTO dto = new BookDTO();
			
			// bookNo
			// bookName, bookTel, bookSrtdate, bookEnddate, bookRequest
			// totalPrice, memberId, bookDate, people, roomNo
			// bookEmail
			
			// 세션에 저장된 정보 불러오기
			// memberName, srtdate, enddate, memberId, people, roomNo
			// dto.setBookName(info.getMemberName()); // 세션에서 불러올 필요 없음..
			dto.setBookSrtdate(info.getSrtDate());
			dto.setBookEnddate(info.getEndDate());
			dto.setMemberId(info.getMemberId());
			dto.setPeople(Integer.parseInt(info.getPeople()));
			dto.setRoomNo(info.getRoomNo());
			
			// 세션에 저장되지 않은 정보 불러오기
			// bookTel,
			// 전화번호, 이메일, 예약요청사항
			// 세션에서 받은 이름: 멤버 이름!
			// jsp에서 받은 이름: 예약 이름 (멤버 이름과 다를 수 있음...)
			
			dto.setBookName(req.getParameter("name"));
			dto.setBookTel(req.getParameter("phone"));
			dto.setBookEmail(req.getParameter("email"));
			dto.setBookRequest(req.getParameter("message"));
			
			// book DB입력
			dao.insertBook(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		// forward(req, resp, "/WEB-INF/campingutte/book/book_ok.jsp");
		
		// 버튼?눌렀을 때 예약확인서로...
		// 아니면 그냥?
		// forward(req, resp, "/WEB-INF/campingutte/book/confirm.jsp");
		resp.sendRedirect(cp+"/book/confirm.do");
	}
	
	protected void bookConfirm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 예약확인서 출력
		BookDAO dao = new BookDAO();
		MyUtil util = new MyUtil();
		
		String cp = req.getContextPath();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			/*
			keyword = URLDecoder.decode(keyword,"utf-8");
			
			if (keyword.length() != 0) {
				query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
			}
			*/
			
			// book에서 가져오기 (==> 얘도 세션으로 처리해야 할 듯)..
			// TODO
			
			// BookDTO dto = dao.readBook(BookNo); // 이거로 써야 함
			BookDTO dto = dao.readBook("BookNo"); // 임시
			
			// 예약확인서가 없으면 메인으로 리턴.. 
			if (dto==null) {
				resp.sendRedirect(cp+"/");
				return;
			}
			
			dto.setBookRequest(util.htmlSymbols(dto.getBookRequest()));
			
			// JSP로 전달할 속성
			req.setAttribute("dto", dto);
			// req.setAttribute("query", query);
			
			// 예약확인서.jsp 로 포워딩
			forward(req,resp,"/WEB-INF/campingutte/book/confirm.jsp");
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// Redirect 처리
		resp.sendRedirect(cp+"/book/book.do");
		// resp.sendRedirect(cp+"/book/book.do?"+query);
		// TODO: 쿼리 추가 or 세션 수정
	}
}
