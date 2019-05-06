var commentsService = {
	setCommentFormReplyHandlers: function(){
		$(".reply-text[login-required='false']").click(function(){
			var commentId = $(this).attr("data-comment-id")
			$("#comment-" + commentId + "-comment-form").removeClass("d-none");
		});
	},
	resetCommentForm: function(formId){
		$("#" + formId + " [name='comment[body]']").val('');
	},
	setCommentsCounters: function(string){
		$(".comments-counter").each(function() {
			$(this).text(string);
		});
	},
	setCommentFormCancelHandlers: function(){
		$("form[action='/comments'] .cancel-link").click(function(){
			var commentableType =  $(this).attr("data-commentable-type");
			var commentableId = $(this).attr("data-commentable-id");
			commentsService.resetCommentForm(commentableType + "-" + commentableId + "-comment-form")
		});
	},
	setHandlers:function(){
		commentsService.setCommentFormCancelHandlers();
		commentsService.setCommentFormReplyHandlers();
	}
}
