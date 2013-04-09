
user_id = null

# Initialize page
init = ->
	# Check to see if user has logged in before.
	forge.prefs.get('user_id', login_or_create_login);


login_or_create_login = (saved_user_id) ->
	# If user doesn't exist, open login page
	if not saved_user_id
		window.location = 'login.html'
		return
	user_id = saved_user_id
	# Login and get latest articles.
	forge.facebook.hasAuthorized(
		get_latest,
		(error) ->
			alert('Error signing in')
			forge.facebook.logout(
				->
					window.location = 'login.html'
			)
	)


get_latest = ->
	get_latest_url = 'http://connectedworld-dev.herokuapp.com/app/get/' + user_id + '/latest/'

	options =
		url: get_latest_url,
		type: 'GET',
		dataType: 'json',

		success: (response) ->
			if response.error
				alert('There was an error getting the latest articles.')
				return

			row = $('<div />').attr(
					class: 'row'
				)

			$('.content').append(row)

			for article in response
				image = $('<img />').attr(
					class: 'article_box_image',
					src: article.image_url,
					# width: '160',
					# height: '160'
				)

				title = $('<div />').attr(
					class: 'article_box_title'
				)

				title.text(article.title)

				box = $('<div />').attr(
					id: article.id.toString(),
					class: 'article_box span2'
				)
				
				box.append(title)
				box.append(image)
				
				box.click(
					(e) ->
						forge.prefs.set(
							'next_article_id',
							this.id,
							->
								window.location = 'article.html'
						)
				)

				row.append(box)


	forge.request.ajax(options)



# Set initialize
$(document).ready(init)
