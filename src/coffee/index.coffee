# Initialize page
init = ->
	# Check to see if user has logged in before.
	forge.prefs.get('user_id', login_or_create_login);


login_or_create_login = (user_id) ->
	# If user doesn't exist, open login page
	if not user_id
		window.location = 'login.html'
		return
	# Login and get latest articles.
	forge.facebook.hasAuthorized(
		get_items,
		(error) ->
			alert('Error signing in')
			forge.facebook.logout(
				->
					window.location = 'login.html'
			)
	)


get_items = ->
	alert('Getting articles')
	# Get latest articles




# Set initialize
$(document).ready(init)
