
# Globals
user_id = null
article_id = null

# Initialize page
init = ->
	# Check to see if user has logged in before.
	forge.prefs.get(
		'user_id',
		(saved_user_id) ->
			if not saved_user_id
				alert('Not logged in')
				window.location = 'index.html'
				return
			user_id = saved_user_id
	)

	forge.prefs.get(
		'next_article_id',
		(next_article_id) ->
			if not next_article_id
				article_id = 2
				get_article()
				return
			article_id = next_article_id
			get_article()
	)


get_article = ->
	get_article_url = 'http://connectedworld-dev.herokuapp.com/app/get/' + user_id + '/article/' + article_id + '/'

	options =
		url: get_article_url,
		type: 'GET',
		dataType: 'json',

		success: (response) ->
			if response.error
				alert('There was an error getting the latest articles.')
				return

			title = $('<h1 />').attr(
				class: 'article_title',
			)
			title.text(response.title)

			author = $('<h4 />')
			author.text('by ' + response.author)

			img = $('<img />').attr(
				class: 'article_img',
				src: response.image_url,
				width: 360,
				height: 360,
			)

			body = response.body

			body_div = $('<div />').attr(
				class: 'article_body'
			)
			body_div.append(body)

			article = $('<div />').attr(
				class: 'article',
				id: response.id
			)

			share_button = $('<div />').attr(
				class: 'btn btn-success'
			)
			share_button.text('Share')

			$('.content').append(article)
			article.append(title)
			article.append(author)
			article.append(img)
			article.append('<br/><br/>')
			article.append(share_button)
			article.append('<br/><br/>')
			article.append(body)

			share_button.click(
				share_facebook
			)

	forge.request.ajax(options)


share_facebook = (e) ->
	options =
		method: 'feed',
		name: 'Connected World!',
		link: 'http://connectedworld-dev.herokuapp.com/',
		picture: 'http://connectedworldmag.com/images/CWMag.jpg',
		caption: 'Share the news',
		description: 'Quality tech news, delivered fast.'
		
	forge.facebook.ui(
		options,
		(response) ->
			if response and response.post_id
				alert('Post was published.');
			else
				alert('Post was not published.');
	)



# Set initialize
$(document).ready(init)
