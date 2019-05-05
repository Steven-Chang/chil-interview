var setCommentsCounters = function(string) {
	$(".comments-counter").each(function() {
		$(this).text(string);
	});
};

var resetCommentForm = function(formId) {
	$("#" + formId + " [name='comment[body]']").val('');
};
