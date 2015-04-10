function friendRequest(friend){
	$.ajax({
		url : '/users/' + friend + '/friend_requests.json',
		type : 'post',
		error : function(jqXHR, textStatus, errorThrown) {
			alert('There was a problem loading the requested content. Please try again later');
		},
		success : function(html, resultText) {
			$('#send_friend_request').hide();
			$('#friend_request_sent').fadeIn();
		}
	});
}

function triggerCanvas(data){
	$('#overlay').html('');
	loadHtml(data);
	showCanvas();
}

function showCanvas(){
	$('#overlayBlurr').fadeToggle();
	$('#overlay').fadeToggle();
}

function hideCanvas(){
	$('#overlayBlurr').fadeOut();
	$('#overlay').fadeOut();
}


function loadHtml(data){
	$.ajax({
		url : data.getAttribute("data-url") + "?item_type=" + data.getAttribute("data-item-type") + "&voting_type=" + data.getAttribute("data-voting-type"),
		error : function(jqXHR, textStatus, errorThrown) {
			alert('There was a problem loading the requested content. Please try again later');
		},
		success : function(html, resultText) {
			$('#overlay').html(html);
		}
	});
}

$(document).ready(function() {

	// close canvas on pressing ESC
	$(document).keyup(function(e) {
		if (e.keyCode == 27) hideCanvas();   // esc
	});

		
	// hide canvas when clicking on glass panel
	$('#overlayBlurr').click(function(){
		hideCanvas();
	});

	// Navbar categories popup
	$('#show_categories').popover({
		'content': $('#categories_popover_content').html(),
		'placement': 'bottom',
		'html': 	true,
		'title': 	'Categories:',
		'trigger': 'focus',
		container: 	'body'
	});

	// send friend request ! no popup ! straight to ajax action
	$('#send_friend_request').click(function(){
		friendRequest($(this).data('friend'));
	});

	// globally enables bootstrap tooltips wherever configured
	$('[data-toggle="tooltip"]').tooltip()

	// distribute tiles
	$('#v_tile_container').BlocksIt({
		numOfCol: Math.floor(($('#v_tile_container').width()) / 225),
		offsetX: 8,
		offsetY: 8,
		blockElement: '.grid'
	});

	// user dob datepicker
	$('#datepicker').datepicker({
		viewMode: 'years'
	});

	$('#trigger_report_voting').click(function(){
		triggerCanvas(this)
	});

	
	$('#new_voting').click(function(){
		triggerCanvas(this)
	});

	$('#new_image_item').click(function(){
		triggerCanvas(this)
	});
	
	$('#sign_in').click(function(){
		triggerCanvas(this)
	});

	
});
