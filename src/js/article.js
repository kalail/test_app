// Generated by CoffeeScript 1.4.0
(function() {
  var article_id, get_article, init, share_facebook, user_id;

  user_id = null;

  article_id = null;

  init = function() {
    forge.prefs.get('user_id', function(saved_user_id) {
      if (!saved_user_id) {
        alert('Not logged in');
        window.location = 'index.html';
        return;
      }
      return user_id = saved_user_id;
    });
    return forge.prefs.get('next_article_id', function(next_article_id) {
      if (!next_article_id) {
        article_id = 2;
        get_article();
        return;
      }
      article_id = next_article_id;
      return get_article();
    });
  };

  get_article = function() {
    var get_article_url, options;
    get_article_url = 'http://connectedworld-dev.herokuapp.com/app/get/' + user_id + '/article/' + article_id + '/';
    options = {
      url: get_article_url,
      type: 'GET',
      dataType: 'json',
      success: function(response) {
        var article, author, body, body_div, img, share_button, title;
        if (response.error) {
          alert('There was an error getting the latest articles.');
          return;
        }
        title = $('<h1 />').attr({
          "class": 'article_title'
        });
        title.text(response.title);
        author = $('<h4 />');
        author.text('by ' + response.author);
        img = $('<img />').attr({
          "class": 'article_img',
          src: response.image_url,
          width: 360,
          height: 360
        });
        body = response.body;
        body_div = $('<div />').attr({
          "class": 'article_body'
        });
        body_div.append(body);
        article = $('<div />').attr({
          "class": 'article',
          id: response.id
        });
        share_button = $('<div />').attr({
          "class": 'btn btn-success'
        });
        share_button.text('Share');
        $('.content').append(article);
        article.append(title);
        article.append(author);
        article.append(img);
        article.append('<br/><br/>');
        article.append(share_button);
        article.append('<br/><br/>');
        article.append(body);
        return share_button.click(share_facebook);
      }
    };
    return forge.request.ajax(options);
  };

  share_facebook = function(e) {
    var options;
    options = {
      method: 'feed',
      name: 'Connected World!',
      link: 'http://connectedworld-dev.herokuapp.com/',
      picture: 'http://connectedworldmag.com/images/CWMag.jpg',
      caption: 'Share the news',
      description: 'Quality tech news, delivered fast.'
    };
    return forge.facebook.ui(options, function(response) {
      if (response && response.post_id) {
        return alert('Post was published.');
      } else {
        return alert('Post was not published.');
      }
    });
  };

  $(document).ready(init);

}).call(this);
