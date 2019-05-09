$(document).ready(function() {
	tagIt.init();
	authenticationService.setLoginRequiredHandlers();
	commentsService.setHandlers();
	paymentService.initStripeForm();
});
