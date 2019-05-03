$(document).ready(function() {
    $("#tags").tagit({
    	fieldName: "post[tag_list][]",
		  afterTagAdded: function(event, ui){
		    // Do something special as you want
		  },
		  afterTagRemoved: function(event, ui){
		    // Do something special as you want
		  }
    });
});
