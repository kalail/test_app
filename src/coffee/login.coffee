logger = forge.logging

# Initialize page
init = ->
	# Fade in the jumbotron
	$('.jumbotron').fadeIn()
	# Set swipe handler
	$(document).on('swipeLeft', handle_swipe_left)
	# Set login button handler
	$('.btn-primary').click(login); 


# Handle a swipe to the left
handle_swipe_left = ->
	$('.jumbotron').fadeOut(open_about)


# Open login page
open_about = ->
	window.location = 'about.html'


open_index = ->
	window.location = 'index.html'


login = ->
	forge.facebook.authorize(
		login_success,
		login_error
	)


login_success = (token_information) ->
	# Get token information
	access_token = token_information.access_token
	# Save token
	forge.prefs.set('facebook_access_token', access_token, open_index)


login_error = (error) ->
	# Display error
	alert('Error: ' + error)

update_user = (access_token) ->


# Set initialize
$(document).ready(init)
