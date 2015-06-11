# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery -> 
	$('button#enable_bidline').click ->
		if $('.enable_bidline_text').text() == 'Enable'
			isGood = confirm("Warning: If you enable this field and change your line number, 
							all your previous shifts will be deleted! New line number will generate new shifts on calendar. 
							\n\n Do you want to enable this field?")
		if isGood
			if $('.enable_bidline_text').text() == 'Enable'
		    	text = 'Disable'
		    	value = false
		else
		    text = 'Enable'
		    value = true

		$('.enable_bidline_text').text text

		$('#user_profile_attributes_bid_line').prop 'disabled', value

		
			
	  
        
    	