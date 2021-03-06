<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="/WEB-INF/views/layout/userHeader.jsp"/>
<script type="text/javascript" src="/resources/js/mainPage.js"></script>
<script type="text/javascript">
function pagingSelect(pagingNumber) {
	$.ajax({
		type: "get"
		, url: "/main/ajax"
		, dataType: "html"
		, data: {
			curPage: pagingNumber
		}
		, success: function(res){
			console.log("success")
			console.log(pagingNumber)
			$("#targetAjax").html(res);
			
		}
		, error: function() {
			console.log("error");
		}
	});
}
</script>
<section>
<div id="wrapper-main">
      <div id="slider-wrap">
          <ul id="slider">
          	 <c:forEach items="${list2 }" var="info">
          	 <li class="text-center">
                <div>
                    <h3>${info.iTitle }</h3>
                    <span>${info.iCategory }</span>
                </div>  
				<c:choose>
				<c:when test = "${fn:contains(info.iStoredName, 'test')}">
					<a href="/story?pNo=${info.pNo }"><img src="/resources/img/logo.png" style="width: 400px; height: 400px; margin: 0 auto;"></a>
				</c:when>
				<c:otherwise>
					<a href="/story?pNo=${info.pNo }"><img src="/upload/information/${info.iStoredName }"/></a>
				</c:otherwise>
			</c:choose>
             </li>
          	 </c:forEach>
          </ul>
          
           <!--controls-->
          <div class="btns" id="next"><i class="fa fa-arrow-right"></i></div>
          <div class="btns" id="previous"><i class="fa fa-arrow-left"></i></div>
          <div id="counter"></div>
          
          <span id="moveProject" class="moveProject"><i class="fas fa-info-circle fa-2x"></i></span>
          
          <div id="pagination-wrap">
            <ul>
            </ul>
          </div>     
      </div>
   </div>
</section>
<section id="wrapper-section">
<div id="targetAjax" class="left">
	<c:forEach items="${list }" var="info">
		<div>
			<c:choose>
				<c:when test = "${fn:contains(info.iStoredName, 'test')}">
					<a href="/story?pNo=${info.pNo }"><img src="/resources/img/subLogo.png" width="200" height="150"/></a>
				</c:when>
				<c:otherwise>
					<a href="/story?pNo=${info.pNo }"><img src="/upload/information/${info.iStoredName }" width="200" height="150"/></a>
				</c:otherwise>
			</c:choose>
			<p>${info.iTitle }</p>
		</div>
	</c:forEach>
	
	<div id="pagination-wrap2">
			<ul>
			<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="page">
			<c:if test="${paging.curPage eq page }">
				<a onclick="pagingSelect(${page})"><li class="active"></li></a>
			</c:if>
			<c:if test="${paging.curPage ne page }">
				<a onclick="pagingSelect(${page})"><li></li></a>
			</c:if>
			</c:forEach>
            </ul>
    </div>
</div>
<div id="realTimeRanking" class="right">
	<h3>????????? ??????</h3>
	<ol>
		<li><a href="https://www.google.com/">?????? 1</a><p>4231% ??????</p></li>
		<li><a href="https://www.google.com/">?????? 2</a><p>1231% ??????</p></li>
		<li><a href="https://www.google.com/">?????? 3</a><p>331% ??????</p></li>
		<li><a href="https://www.google.com/">?????? 4</a><p>231% ??????</p></li>
		<li><a href="https://www.google.com/">?????? 5</a><p>1111% ??????</p></li>
	</ol>
</div>
	
</section>
<c:import url="/WEB-INF/views/layout/footer.jsp"/>
