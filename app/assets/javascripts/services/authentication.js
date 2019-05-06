var authenticationService = {
	loginRequired: function(){
		window.location = "/login";
	},
	setLoginRequiredHandlers: function(){
		$("[login-required='true']").click(function(){
			authenticationService.loginRequired();
		});
	},
	userNotAuthorized: function(){
		window.location = "/";
	}
}
