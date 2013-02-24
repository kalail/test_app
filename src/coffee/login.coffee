logger = forge.logging

# Initialize page
init = ->
	# Fade in the jumbotron
	$('.jumbotron').fadeIn()
	# Set swipe handler
	$(document).on('swipeLeft', handle_swipe_left)
	# Set login button handler
	$('.btn-primary').click(login)


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
	# Get facebook profile
	forge.facebook.api(
		'/me',
		{
			fields: 'name,id,username,gender,location,picture,timezone'
		},
		(user) ->
			# Get facebook information
			options =
				url: 'http://connectedworld-dev.herokuapp.com/app/login/',
				type: 'GET',
				data:
					facebook_access_token: token_information.access_token,
					facebook_id: user.id,
					name: user.name,
					username: user.username,
					gender: user.gender,
					location: user.location.name,
					picture: user.picture.data.url,
					timezone: user.timezone,
				dataType: 'json',

				success: (response) ->
					logger.log(response.new)
					if response.new == true
						alert('Welcome ' + response.user_name)
					# Save token
					forge.prefs.set('user_id', response.user_id)
					forge.prefs.set('user_name', response.user_name)
					forge.prefs.set('user_picture', response.user_picture, open_index)

			# Post it to server
			forge.request.ajax(options)
	)


login_error = (error) ->
	# Display error
	alert('Error: ' + error)



# Set initialize
$(document).ready(init)
