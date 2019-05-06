var commentsService = {
	setCommentFormReplyHandlers: function(){
		$(".reply-text[login-required='false']").click(function(){
			var commentId = $(this).attr("data-comment-id");
			showJqueryElement($("#comment-" + commentId + "-comment-form"));
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
			var commentFormId = commentableType + "-" + commentableId + "-comment-form";
			commentsService.resetCommentForm(commentFormId);
			if(commentableType == "comment"){
				hideJqueryElement($("#" + commentFormId));
			};
		});
	},
	setHandlers:function(){
		commentsService.setCommentFormCancelHandlers();
		commentsService.setCommentFormReplyHandlers();
	}
}
