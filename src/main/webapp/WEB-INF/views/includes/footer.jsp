<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

 <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                    </div>
                </div>
            </footer>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
   <div class="modal fade" tabindex="-1" id="resultModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">JKPOP</h5>
      </div>
      <div class="modal-body">
        <p>${result }</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary"  id="closeModalBtn">Close</button>
      </div>
    </div>
  </div>
</div>
<c:if test="${param.logout != null }">
	<script>
		$(function(){
			alert("logoutしました。");
		});
	</script>
</c:if>
  <script type="text/javascript">
	$(function(){
		if(history.state) return;
		if('${result}') $("#resultModal").modal("show");
		history.replaceState({},null,null);
		
		$("#closeModalBtn").on("click",function(){
			$("#resultModal").modal("hide");
		})
		
		$(".logoutBtn").on("click",function(e){
			alert("logoutしました");
			e.preventDefault();
			$("#logoutForm").submit();
		});
		
	})

</script>





