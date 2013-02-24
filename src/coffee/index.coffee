# Initialize page
init = ->
	# Check to see if user has logged in.
	forge.prefs.get('facebook_access_token', login_or_create_login);


login_or_create_login = (token) ->
	# If user doesn't exist, open login page
	if not token
		open_login()
		return

	alert(token)


# Open login page
open_login = ->
	window.location = 'login.html'


# Set initialize
$(document).ready(init)
