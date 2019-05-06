var commentsService = {
	displayCommentFormOnReplyClick: function(){
		$(".reply-link[login-required='false']").click(function(){
			var commentId = $(this).attr("data-comment-id")
			$("#comment-" + commentId + "-comment-form").removeClass("d-none");
		});
	},
	preventReplyLinkDefaultBehaviour: function(){
		$(".reply-link").click(function(event){
			event.preventDefault();
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
	setReplyLinkHandlers: function(){
		commentsService.preventReplyLinkDefaultBehaviour();
		commentsService.displayCommentFormOnReplyClick();
	}
}
