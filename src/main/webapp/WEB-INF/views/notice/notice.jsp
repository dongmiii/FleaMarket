<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../includes/header.jsp"%>
<div class="row">
	<div class="col-lg-12">
		<div class="section-top-border">
			<h3 class="mb-30" style="font-family:나눔스퀘어_ac;">NOTICE BOARD</h3>
			<div class="progress-table-wrap">
				<div class="progress-table">
					<div class="table-head">
						<div class="serial">NO.</div>
						<div class="country">Title</div>
						<div class="visit">Writer</div>
						<div class="visit">Date</div>
						<div class="visit">Views</div>
					</div>
					<c:forEach var="notice" items="${notice}">
						<div class="table-row">
							<div class="serial">
								<c:out value="${notice.no}"></c:out>
							</div>
							<div class="country">
								<a class='move' href='<c:out value="${notice.no}"/>'> <c:out
										value="${notice.title}"></c:out>
								</a>
							</div>
							<div class="visit">
								<c:out value="${notice.writer}"></c:out>
							</div>
							<div class="visit">
								<c:out value="${notice.updatedate}"></c:out>
							</div>
							<div class="visit">
								<c:out value="${notice.hits}"></c:out>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>

		<section class="blog_area">
			<div class="container">
				<div class="row">
					<div class="col-lg-12 mb-5 mb-lg-0">
						<div class="blog_left_sidebar">
							<nav class="blog-pagination justify-content-center d-flex">
								<ul class="pagination">
									<c:if test="${pageMaker.prev}">
										<li class="page-item"><a href="${pageMaker.startPage-1}"
											class="page-link" aria-label="Previous"> <i
												class="ti-angle-left"></i>
										</a></li>
									</c:if>
									<c:forEach var="num" begin="${pageMaker.startPage}"
										end="${pageMaker.endPage}">
										<li
											class='page-item ${pageMaker.cri.pageNum == num ? "active" : ""}'>
											<a href="${num}" class="page-link">${num}</a>
										</li>
									</c:forEach>
									<c:if test="${pageMaker.next}">
										<li class="page-item"><a href="${pageMaker.endPage+1}"
											class="page-link" aria-label="Next"> <i
												class="ti-angle-right"></i>
										</a></li>
									</c:if>
								</ul>
							</nav>
						</div>
					</div>
				</div>
			</div>
		</section>
	
		<form id='actionForm' action="/notice/notice" method='get'>
			<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
			<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
		</form>

		<sec:authorize access="hasAnyRole('ROLE_MASTER')">
			<div class="button-group-area mt-10">
				<a href="/notice/form" class="genric-btn danger-border">WRITE</a>
			</div>
		</sec:authorize>
	</div>
</div>
<script type="text/javascript">
	$(document)
			.ready(
					function() {

						var result = '<c:out value="${result}"/>';
						checkModal(result);
						history.replaceState({}, null, null);

						function checkModal(result) {
							if (result === '' || history.state) {
								return;
							}
							if (parseInt(result) > 0) {
								$(".modal-body").html(
										"게시글 " + parseInt(result)
												+ " 번이 등록되었습니다.");
							}
							//$("#myModal").modal("show");
						}

						var actionForm = $("#actionForm");
						$(".paginate_button a").on(
								"click",
								function(e) {
									e.preventDefault();
									console.log('click');
									actionForm.find("input[name='pageNum']")
											.val($(this).attr("href"));
									actionForm.submit();
								});

						$(".move")
								.on(
										"click",
										function(e) {
											e.preventDefault();
											actionForm
													.append("<input type='hidden' name='no' value='"
															+ $(this).attr(
																	"href")
															+ "'>");
											actionForm.attr("action",
													"/notice/get");
											actionForm.submit();
										});
					});
</script>


<%@ include file="../includes/footer.jsp"%>