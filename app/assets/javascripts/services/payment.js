// https://stripe.com/docs/stripe-js/elements/quickstart#create-form

var paymentService = {
	submitting: false,
	displayErrorMessageToPaymentForm: function(message){
		$("#card-errors").text(message);
	},
	initStripeForm: function(){
		var stripe = Stripe('pk_test_w7J0ivp4RxCIgwB1odGU1HmD000xEdprlj');
		var stripeElements = stripe.elements();

		// Custom styling can be passed to options when creating an Element.
		var style = {
		  base: {
		    color: '#32325d',
		    fontFamily: '"Helvetica Neue", Helvetica, sans-serif',
		    fontSmoothing: 'antialiased',
		    fontSize: '16px',
		    '::placeholder': {
		      color: '#aab7c4'
		    }
		  },
		  invalid: {
		    color: '#fa755a',
		    iconColor: '#fa755a'
		  }
		};

		// Create an instance of the card Element.
		var card = stripeElements.create('card', {style: style});

		// Add an instance of the card Element into the `card-element` <div>.
		card.mount('#card-element');
		// Create a token or display an error when the form is submitted.
		var form = document.getElementById('payment-form');
		form.addEventListener('submit', function(event) {
			if(!paymentService.submitting){
				paymentService.submitting = true;
			  event.preventDefault();

			  stripe.createToken(card).then(function(result) {
			    if (result.error) {
			      // Inform the customer that there was an error.
			      var errorElement = document.getElementById('card-errors');
			      errorElement.textContent = result.error.message;
			    } else {
			      // Send the token to your server.
			      paymentService.stripeTokenHandler(result.token);
			    }
			  });
			};
		});
	},
	stripeTokenHandler: function(token){
	  // Insert the token ID into the form so it gets submitted to the server
	  var form = document.getElementById('payment-form');
	  var hiddenInput = document.createElement('input');
	  hiddenInput.setAttribute('type', 'hidden');
	  hiddenInput.setAttribute('name', 'stripeToken');
	  hiddenInput.setAttribute('value', token.id);
	  form.appendChild(hiddenInput);

	  // Submit the form
	  form.submit();
	}
}