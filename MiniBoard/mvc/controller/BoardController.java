package mvc.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.model.BoardDTO;
import mvc.model.BoardDAO;
import mvc.model.BoardReply;

public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final int LISTCOUNT = 5;
	
	//Get방식으로 오는 요청은 doPost로 보냄
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}
	
	//Post 방식으로 오는 요청을 처리
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//요청된 URL만 추출
		String RequestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = RequestURI.substring(contextPath.length());
		
		response.setContentType("text/html; charset=utf-8");
		request.setCharacterEncoding("utf-8");
		
		if(command.equals("/BoardListAction.do")) { //등록된 글 목록 페이지 출력하기
			requestBoardList(request);
			RequestDispatcher rd = request.getRequestDispatcher("./list.jsp");
			rd.forward(request, response);
		} else if(command.equals("/BoardWriteForm.do")) { //글 등록 페이지 출력
			requestLoginName(request);
			RequestDispatcher rd = request.getRequestDispatcher("./writeForm.jsp");
			rd.forward(request, response);
		} else if(command.equals("/BoardWriteAction.do")) { //새로운 글 등록
			requestBoardWrite(request);
			RequestDispatcher rd = request.getRequestDispatcher("/BoardListAction.do");
			rd.forward(request, response);
		} else if(command.equals("/BoardViewAction.do")) { //선택된 글 상자 페이지 가져오기
			requestBoardView(request);
			RequestDispatcher rd = request.getRequestDispatcher("/BoardView.do");
			rd.forward(request, response);
		} else if(command.equals("/BoardView.do")) { //글 상세 페이지 출력하기
			RequestDispatcher rd = request.getRequestDispatcher("./view.jsp");
			rd.forward(request, response);
		} else if(command.equals("/BoardUpdateAction.do")) { //선택된 글 수정하기
			requestBoardUpdate(request);
			RequestDispatcher rd = request.getRequestDispatcher("/BoardListAction.do");
			rd.forward(request, response);
		} else if(command.equals("/BoardDeleteAction.do")) { //선택된 글 삭제하기
			requestBoardDelete(request);
			RequestDispatcher rd = request.getRequestDispatcher("/BoardListAction.do");
			rd.forward(request, response);
		} else if(command.equals("/ReplyAction.do")) { //댓글 등록하기
			requestReplyWrite(request);
			//replywrite를 하면 db에 댓글이 등록이 되고
			//다시 view 페이지를 refresh를 시키기 위해 BoardViewAction.do로 간다
			RequestDispatcher rd = request.getRequestDispatcher("/BoardViewAction.do");
			rd.forward(request, response);
		}
	}
	
	//새로운 댓글 등록
	public void requestReplyWrite(HttpServletRequest request) {
		//여기에서 num과 pageNum을 view의 두번째 form에서 받아와야한다.
		//그 이유는 이 메서드가 끝나고 BoardViewAction.do로 가는데
		//그곳에서 num과 pageNum을 request를 한다. 그때 request를 하기 위해서
		//request에 num과 pageNum을 set해줘야함
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		request.setAttribute("num", num);
		request.setAttribute("pageNum", pageNum);
		
		BoardDAO dao = BoardDAO.getInstance();		
		
		BoardReply reply = new BoardReply();
		reply.setId(request.getParameter("id"));
		reply.setName(request.getParameter("name"));
		reply.setPage_num(Integer.parseInt(request.getParameter("num")));
		
		reply.setReplycontent(request.getParameter("reply"));
		
		//System.out.println(request.getParameter("name"));
		//System.out.println(request.getParameter("subject"));
		//System.out.println(request.getParameter("content"));
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd(HH:mm:ss)");
		String regist_day = formatter.format(new java.util.Date()); 
		
		reply.setTime(regist_day);
		
		
		
		dao.insertReply(reply);
	}
	//댓글 수정하기
	
	//댓글 삭제하기
	
	//등록된 글 목록 가져오기
	public void requestBoardList(HttpServletRequest request) {
		//BoardDTO의 값들을 제어하는 dao를 만듬
		BoardDAO dao = BoardDAO.getInstance();
		//DTO는 게시물의 정보를 가짐.
		//화면에 보이는 게시물이 하나가 아니기 때문에 list로 그 리스트는 DTO 형식으로 되어있으니
		//그 리스트 정보들을 ArrayList로 만들어서 boardlist로 만들어준다.
		List<BoardDTO> boardlist = new ArrayList<BoardDTO>();
		
		//시작 페이지 기본값
	  	int pageNum=1;
	  	//한 페이지에 최대로 표시할 게시물 수
		int limit=LISTCOUNT;
		
		//한 페이지에 표시되는 게시물이 최대 5개
		//5개 초과가 되면 페이지 2가 만들어진다.
		//그래서 list.jsp에서 페이지 1,2,3...로 갈 수 있는 링크가 있다.
		//3번을 클릭하면 페이지 3번으로 가는데 그 때 pageNum이 3이 된다.
		//결론은 페이지 전환할 때 필요한 코드
		//if문은 디펜스 코드
		if(request.getParameter("pageNum")!=null)
			pageNum=Integer.parseInt(request.getParameter("pageNum"));
		
		//search부분할 때 필요한 애들인듯
		//게시판 처음 뜰 때는 select 선택이 안되어 있기 때문에 초기값은 null
		String items = request.getParameter("items");
		String text = request.getParameter("text");
		
		//dao에서 행의 개수를 가져옴
		int total_record=dao.getListCount(items, text);
		//getBoardList에서 5개의 게시물을 받아옴
		boardlist = dao.getBoardList(pageNum,limit, items, text); 
		
		int total_page;
		
		//전체 행 / limit(5)의 나머지가 0이면
		if (total_record % limit == 0){
			// 전체 행(10개라고 가정) / limit = 2
			//total_page를 2로 설정, 한 페이지에 5개의 게시물이 있으니까
	     	total_page =total_record/limit; 
	     	//floor는 소수점을 가질 경우 소수점을 버리고 그 보다 작거나 같은 최대의 *정수*를 반환
	     	//정수로 다시 반환을 받아야하는 이유는 나눗셈을 하려면 double 타입으로 나눗셈을 해야하기 때문
	     	Math.floor(total_page);
		}
		else{
			//전체 행이 11이라고 하면 11 % 5 = 1
			//그러면 전체 페이지는 3이 되어야함
			total_page =total_record/limit;
		    Math.floor(total_page); 
		    total_page =  total_page + 1; 
		}		
   
		//list.jsp로 request를 넘겨줌
   		request.setAttribute("pageNum", pageNum);		  
   		request.setAttribute("total_page", total_page);   
		request.setAttribute("total_record",total_record); 
		request.setAttribute("boardlist", boardlist);	
	}
	
	public void requestLoginName(HttpServletRequest request) {
		String id = request.getParameter("id");
		BoardDAO  dao = BoardDAO.getInstance();
		String name = dao.getLoginNameById(id);		
		request.setAttribute("name", name);		
	}
	
	//새로운 글 등록하기
	public void requestBoardWrite(HttpServletRequest request) {
		BoardDAO dao = BoardDAO.getInstance();		
		
		BoardDTO board = new BoardDTO();
		board.setId(request.getParameter("id"));
		board.setName(request.getParameter("name"));
		board.setSubject(request.getParameter("subject"));
		board.setContent(request.getParameter("content"));	
		
		//System.out.println(request.getParameter("name"));
		//System.out.println(request.getParameter("subject"));
		//System.out.println(request.getParameter("content"));
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd(HH:mm:ss)");
		String regist_day = formatter.format(new java.util.Date()); 
		
		board.setHit(0);
		board.setRegist_day(regist_day);
		board.setIp(request.getRemoteAddr());			
		
		dao.insertBoard(board);	
	}
	
	//선택된 글 상세 페이지와 등록된 댓글 가져오기
	//원래는 글 상세 페이지와 댓글 가져오기를 나누려고 했는데
	//댓글이 view에 표시되도록 댓글의 목록만 view로 넘겨주면 오류가 생긴다.
	//이유는 view에서 request get을 할 때 댓글 목록만 request를 하는게 아니라
	//게시물 정보(board)도 request 하기 때문에 댓글 목록만 주고
	//view.jsp를 실행시키면 board를 가져올 수 없다고 오류가 뜨기 때문
	public void requestBoardView(HttpServletRequest request) {
		BoardDAO dao = BoardDAO.getInstance();
		
		//여기에서 get하는 시점이 2군데가 있다.
		//list.jsp에서 get을 할 때와 ReplyWrite에서 넘겨주는 걸 받을 때 get
		//ReplyWrite에서 list으로 가지 않기 때문인데
		//ReplyWrite가 끝나면 BoardViewAction으로 간다. 그러면 BoardViewAction에서
		//바로 이곳(BoardView 매서드)로 오는데 그때는 이 num과 pageNum이
		//list.jsp에서 받아오지 않기 때문에 ReplyWrite에서 num과 pageNum을 넘겨줘야한다.
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		
		BoardDTO board = new BoardDTO();
		board = dao.getBoardByNum(num, pageNum);
		
		List<BoardReply> boardCommentlist = new ArrayList<BoardReply>();
		int boardNum = Integer.parseInt(request.getParameter("num"));
		int total_comment_num = dao.getCommentCount(boardNum);	
		boardCommentlist = dao.getCommentList(boardNum);
		
		request.setAttribute("total_comment_num", total_comment_num);
		request.setAttribute("boardcommentlist", boardCommentlist);
		
		request.setAttribute("num", num);
   		request.setAttribute("page", pageNum); 
   		request.setAttribute("board", board);
	}
	
	//선택된 글 내용 수정하기
	public void requestBoardUpdate(HttpServletRequest request) {
		int num = Integer.parseInt(request.getParameter("num"));
		//int pageNum = Integer.parseInt(request.getParameter("pageNum"));	
		
		BoardDAO dao = BoardDAO.getInstance();		
		
		BoardDTO board = new BoardDTO();		
		board.setNum(num);
		board.setName(request.getParameter("name"));
		board.setSubject(request.getParameter("subject"));
		board.setContent(request.getParameter("content"));		
		
		 java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd(HH:mm:ss)");
		 String regist_day = formatter.format(new java.util.Date()); 
		 
		 board.setHit(0);
		 board.setRegist_day(regist_day);
		 board.setIp(request.getRemoteAddr());			
		
		 dao.updateBoard(board);
	}
	
	//선택된 글 삭제하기
	public void requestBoardDelete(HttpServletRequest request) {
		int num = Integer.parseInt(request.getParameter("num"));
		//int pageNum = Integer.parseInt(request.getParameter("pageNum"));	
		
		BoardDAO dao = BoardDAO.getInstance();
		dao.deleteBoard(num);		
	}
}
