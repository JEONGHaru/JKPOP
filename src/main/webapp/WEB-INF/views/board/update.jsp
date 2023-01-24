<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>JKPOP</title>
	<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <!-- Custom fonts for this template-->
    <link href="/resources/pages/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">
<script src="https://kit.fontawesome.com/462b5b874f.js" crossorigin="anonymous"></script>
    <!-- Custom styles for this template-->
    <link href="/resources/pages/css/sb-admin-2.min.css" rel="stylesheet">
<style type="text/css">
ul{
list-style:none;
}
textarea {
    width: 100%;
    height: 6.25em;
    border: none;
    resize: none !important;
  }
  .uploadResult {
  	width:100%
  }
  .uploadResult ul{
  	display:flex;
  	flex-flow:row;
  	justify-content:center;
  	align-items:center;
  }
  .uploadResult ul li {
  	list-style: none;
  	padding: 10px;
  	text-color:white;
  }
</style>
<script type="text/javascript">
$(function(){
	(function(){
	var bno = "${board.bno}";
	$.getJSON("getFileList",{bno:bno},function(arr){
		//console.log(arr);
		var str = "";
		$(arr).each(function(i,uploadFile){
			//image type
		if(uploadFile.fileType){
			var fileCallPath = encodeURIComponent(uploadFile.uploadPath+"/s_"+uploadFile.uuid +"_"+uploadFile.fileName);
			
			str += "<li data-path='"+uploadFile.uploadPath+"' data-uuid='"+uploadFile.uuid+"' data-filename='"
			+uploadFile.fileName+"' data-type='"+uploadFile.fileType+"' ><div>";
			str += "<span>" + uploadFile.fileName+"</span>";
			str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'>";
			str +="<i class='fa-solid fa-trash-can'></i></button><br>"
			str += "<img src='/display?fileName="+fileCallPath+"'>";
			str += "</div>";
			str += "</li>";
		}else{
			var fileCallPath = encodeURIComponent(uploadFile.uploadPath+uploadFile.uuid +"_"+uploadFile.fileName);
			
			str += "<li data-path='"+uploadFile.uploadPath+"' data-uuid='"+uploadFile.uuid+"' data-filename='"
			+uploadFile.fileName+"' data-type'"+uploadFile.fileType+"' ><div>";
			str += "<span> "+ uploadFile.fileName+"</span>";
			str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'>";
			str +="<i class='fa-solid fa-trash-can'></i></button><br>"
			str += "</div>";
			str += "</li>";
		}
	}); // $(arr).each -- end
		$(".uploadResult ul").html(str);
	});//getJSON -- end
	})(); //function -- end
	
	$(".uploadResult").on("click","button",function(e){
		//alert("uploadResult button click");
		if(confirm("ファイルを削除しますか")){
			var targetLi = $(this).closest("li");
			targetLi.remove();
		}
	}); // uploadResult button -- end
	
	var regEx = new RegExp("(.*?)\.(exe|sh|zip|alz)$","i");
	var maxSize = 10485760 // 1024 * 1024 * 10 = 10MB
	
	function chechExtension(fileName,fileSize){
		if(fileSize > maxSize){
			alert("10MB以下のファイルをアップロードしてください");
			return false;
		}
		if(regEx.test(fileName)){
			alert("そのファイルはアップロードできません");
			return false;
		}
		return true;
	} //chechExtension -- end
	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	$("input[type='file']").on("change",function(e){
		//console.log("ファイル選択");
		var formData = new FormData();
		//console.log(formData);
		var inputFile = $("input[name='uploadFile']")
		//console.log(inputFile);
		var files = inputFile[0].files;
		//console.log(files);
		for(var i = 0; i< files.length; i++){
			//ファイルチェック
			if(!chechExtension(files[i].name,files[i].size)){
				return false;
			}
			formData.append("uploadFile",files[i]);
		}
		$.ajax({
			url : "/uploadAjaxAction",
			processData : false,
			contentType : false,
			data : formData,
			type : "POST",
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
			},
			dataType : "JSON",
			success : function(result){
				console.log(JSON.stringify(result));
				//ファイル画面に表示
				showUploadFile(result);
				//$(".uploadDiv input").val("");
			}
		});
	});//input change -- end
	
	function showUploadFile(arr){
		var str = "";
		$(arr).each(function(i,uploadFile){
			//image type
		if(uploadFile.image){
			var fileCallPath = encodeURIComponent(uploadFile.uploadPath+"/s_"+uploadFile.uuid +"_"+uploadFile.fileName);
			
			str += "<li data-path='"+uploadFile.uploadPath+"' data-uuid='"+uploadFile.uuid+"' data-filename='"+uploadFile.fileName+"' data-type='"+000+"' ><div>";
			str += "<span>" + uploadFile.fileName+"</span>";
			str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'>";
			str +="<i class='fa-solid fa-trash-can'></i></button><br>"
			str += "<img src='/display?fileName="+fileCallPath+"'>";
			str += "</div>";
			str += "</li>";
		}else{
			var fileCallPath = encodeURIComponent(uploadFile.uploadPath+uploadFile.uuid +"_"+uploadFile.fileName);
			
			str += "<li data-path='"+uploadFile.uploadPath+"' data-uuid='"+uploadFile.uuid+"' data-filename='"
			+uploadFile.fileName+"' data-type'="+uploadFile.image+"' ><div>";
			str += "<span> "+ uploadFile.fileName+"</span>";
			str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'>";
			str +="<i class='fa-solid fa-trash-can'></i></button><br>"
			str += "</div>";
			str += "</li>";
		}
	}); // $(arr).each -- end
		$(".uploadResult ul").append(str);
		
	}// showUploadFile-- end
	
	var formObj = $("#updateForm");
	$("button[type='submit']").on("click",function(e){
		e.preventDefault();
		//alert("submit click");
		var str = "";
		$(".uploadResult ul li").each(function(i,obj){
			var jobj = $(obj);
			//console.dir(jobj);
			//console.log(jobj.data("type"));
			//console.log(jObj.data("filename"));
			str += "<input type='hidden' name='uploadFileList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
			str += "<input type='hidden' name='uploadFileList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='uploadFileList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
			str += "<input type='hidden' name='uploadFileList["+i+"].fileType' value='"+jobj.data("type")+"'>";
		});//append input tag -- end
		//console.dir(formObj.append(str));
		formObj.append(str).submit();
		
	});//file upload -- end
	
});//$(function()) -- end
</script>    
</head>
<!-- side bar -->
<%@ include file="../includes/sidebar.jsp" %>
<%@ include file="../includes/navToolbar.jsp" %>

<div class="container">
	<div class="row">
		<div class="col-lg-12">
		<!-- ページタイトル -->
			<h1 class="page-header">掲示修正</h1>
		</div>
		<!-- /.row -->
		<div class="row mb-4">
			<div class="col-lg-12">
			<form role="form" method="POST"  id="updateForm">
<%--                  <input type="hidden" name="pageNum" value="${param.pageNum}"> --%>
<%--                  <input type="hidden" name="amount" value="${param.amount}"> --%>
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				<div class="form-group">
					<label>NO</label>
					<input class="form-control mb-3" type="text" name="bno" value="${board.bno}" readonly="readonly">
					<label>タイトル</label>
					<input class="form-control mb-3" type="text" name="title" value="${board.title }"  >
					</div>
					<div class="form-group">
					<label>内容</label>
					<textarea class="form-control mb-3" rows="3" name="content"  >${board.content }</textarea>
					</div>
					<div class="form-group">
					<label>作成者</label>
					<input class="form-control mb-3" type="text" name="writer" value="${board.writer }" readonly="readonly" >
					</div>
					<div class="float-right">
					<sec:authentication property="principal" var="pinfo"/>
					<sec:authorize access="isAuthenticated()">
						<c:if test="${pinfo.username eq board.writer }">
							<button type="button" data-oper="list"  class="btn btn-primary" onclick="history.back()" >キャンセル</button>
							<button type="submit" data-oper="update" class="btn btn-warning">修正</button>
						</c:if>
					</sec:authorize>
                   	</div>
                   	</form>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
		<div class="card shadow">
			<div class="card-header">
				<h5>File</h5>
			</div>
			<div class="card-body">
			<div class="form-group uploadDiv">
					<input class="form-control" type="file"  name="uploadFile" multiple>
				</div>
				<div class="uploadResult bg-secondary text-light">
					<ul></ul>
				</div>
				<!-- /.uploadResult -->
			</div>
			<!-- /.card-body -->
		</div>
		<!-- /.card shadow -->
	</div>
</div>
<%@ include file="../includes/footer.jsp" %>           
            <!-- End of Footer -->
            <!-- Bootstrap core JavaScript-->
    <script src="/resources/pages/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/pages/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/resources/pages/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/resources/pages/js/sb-admin-2.min.js"></script>

<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
</body>

</html>