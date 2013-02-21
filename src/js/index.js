

function facebook_login_success(token_information){
}

function facebook_login_fail(content){
}


function facebook_login(){
	forge.facebook.authorize(
		facebook_login_success,
		facebook_login_fail
	);
}

function go_to_about(){
	window.location="about.html";
}

function check_user_login(user){
	if (user == null)
	{
		// User has not logged in
		return;
	}

	if (user.facebook_id == null)
	{
		return;
	}
	else
	{
		forge.facebook.authorize(
		facebook_login_success,
		facebook_login_fail
		);
	}

}

function init() {
	// Check if user already logged in.
	forge.prefs.get('user' check_user_login, function(){});

 	$(".btn-primary").click(facebook_login);
 	$(".jumbotron").fadeIn();
 }

$(document).on('swipeLeft', function () {
	$(".jumbotron").fadeOut(go_to_about);
})



 $(document).ready(init);