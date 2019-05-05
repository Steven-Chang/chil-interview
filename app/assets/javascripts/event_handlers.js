$(document).ready(function() {
	$("input[login-required='false']").click(function(){
		authenticationService.loginRequired();
	});
})
