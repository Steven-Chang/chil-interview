var authenticationService = {
	loginRequired: function() {
		window.location = "/login";
	},
	userNotAuthorized: function() {
		window.location = "/";
	}
}
