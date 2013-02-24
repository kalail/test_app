# Initialize page
init = ->
	# Fade in the jumbotron
	$('.jumbotron').fadeIn()
	# Set swipe handler
	$(document).on('swipeRight', handle_swipe_right)


# Handle a swipe to the right
handle_swipe_right = ->
	$('.jumbotron').fadeOut(open_login)


# Open login page
open_login = ->
	window.location = 'login.html'


# Set initialize
$(document).ready(init)
