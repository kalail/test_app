



function init() {
  	$(".jumbotron").fadeIn();
 }

function go_to_index(){
	window.location="index.html";
}


 $(document).on('swipeRight', function () {
 	$(".jumbotron").fadeOut(go_to_index);
})



$(document).ready(init);