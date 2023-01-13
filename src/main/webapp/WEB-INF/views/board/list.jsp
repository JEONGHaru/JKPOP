<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html lang="en">
<head>
<style type="text/css">
ul{
	list-style:none;
}
</style>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>BOARD</title>

    <!-- Custom fonts for this template -->
    <link href="/resources/pages/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/resources/pages/css/sb-admin-2.min.css" rel="stylesheet">

    <!-- Custom styles for this page -->
    <link href="/resources/pages/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</head>
<body>
<!-- sidebar -->
<%@include file="../includes/sidebar.jsp" %>
<!--navToolbar  -->
<%@include file="../includes/navToolbar.jsp" %>
 <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h3 class="m-0 font-weight-bold text-gray"> 掲示板</h3>
                        </div>
                        
                        <div class="card-body">
                            <div class="table-responsive">
                            <div class="row mb-2">
                        	<div class="col-lg-12">
                        			<label>
                        				Show
                        				<select class="form-select form-select-sm" id="selAmount">
                        					<option value="10">10</option>
                        					<option value="15">15</option>
                        					<option value="20">20</option>
                        				</select>
                        			</label>
                        		<a href="write" class="btn btn-primary btn-icon-split float-right" >
                        		<span class="icon text-white-50"><i class="fa-solid fa-pen"></i></span>
                        		<span class="text">作成</span>
                        		</a>
                        		</div>
                        </div>
                                <table class="table table-bordered table-hover"  width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>#NO</th>
                                            <th>#タイトル</th>
                                            <th>#作成者</th>
                                            <th>#日付</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>#NO</th>
                                            <th>#タイトル</th>
                                            <th>#作成者</th>
                                            <th>#日付</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                    	<c:forEach var="board" items="${list}">
                                        <tr>
                                            <td>${board.bno }</td>
                                            <td>${board.title }</td>
                                            <td>${board.writer }</td>
                                            <td><fmt:formatDate value="${board.regDate }" pattern="yyyy-MM-dd"/></td>
                                        </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <div class="row">
                                		<form class="col-sm-12 col-lg-6" id="searchForm">
	                                		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
		                           			<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                                			<select name="field" >
                                				<option value="">---</option>
                                				<option value="T">タイトル</option>
                                				<option value="C">内容</option>
                                				<option value="W">作成者</option>
                                				<option value="TC">内容＋タイトル</option>
                                			</select>
                                			<input name="keyword">
                                			<button class="btn btn-secondary">検索</button>
                                		</form>
                                		<div class="col-sm-12 col-lg-6">
	                                		<div class="float-right">
			                                		<ul class="pagination">
			                                		<c:if test="${pageMaker.prev}">
			                                			<li class="paginate_button previous page-item">
			                                				<a class="page-link" href="${pageMaker.startPage-1}">prev</a>
			                                			</li>
			                                			</c:if>
			                                			<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
			                                			<li class="paginate_button page-item ${pageMaker.cri.pageNum == num ? 'active':'' }">
			                                				<a class="page-link"  href="${num}">${num }</a>
			                                			</li>
			                                			</c:forEach>
			                                			<c:if test="${pageMaker.next}">
			                                			<li class="paginate_button previous page-item">
			                                				<a class="page-link"  href="${pageMaker.endPage+1}">next</a>
			                                			</li>
			                                			</c:if>
			                                			</ul>
	                                			</div>
                                		</div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->
            <form id="actionForm" action="list">
            	<!-- 클릭한 href에 들어있는 페이지 번호를 바꿔준다 -->
            	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" id="pageNum">
            	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
            	<input type="hidden" name="field" value="${pageMaker.cri.field}">
            	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
            </form>
<!-- footer -->
<%@include file="../includes/footer.jsp" %>

<script type="text/javascript">
	$(function(){
		//検索データsetting
		var searchForm = $("#searchForm");
		$(searchForm).find("select").val("${param.field}");
		$(searchForm).find("input[name='keyword']").val("${param.keyword}");
		
		//console.log("${pageMaker.cri.pageNum}")
		$("#selAmount").val("${param.amount}");
		$("#selAmount").on("change",function(){
			//alert($("#selAmount").val());
			location = "list?amount="+$(this).val();
		});
		//var actionForm = $("#actionForm");
		$(".paginate_button a").on("click",function(e){
			//ページリンクを無効うにする = return false
			e.preventDefault();
			//actionForm.find("input[name=pageNum]")
			$("#pageNum").val($(this).attr("href"));
			$("#actionForm").submit();
		});
		
	});//function()--end
</script>
  <!-- Bootstrap core JavaScript-->
    <script src="/resources/pages/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/pages/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/resources/pages/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/resources/pages/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="/resources/pages/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="/resources/pages/vendor/datatables/dataTables.bootstrap4.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="/resources/pages/js/demo/datatables-demo.js"></script>
    
</body>
</html>