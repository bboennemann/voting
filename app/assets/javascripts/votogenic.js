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

function set_bookmark(voting){
	$.ajax({
		url : '/votings/' + voting + '/bookmarks.json',
		type : 'post',
		error : function(jqXHR, textStatus, errorThrown) {
			alert('There was a problem loading the requested content. Please try again later');
		},
		success : function(response, resultText) {
			$('.toggle_bookmark').toggleClass('text-warning');
		}
	});
}

// regular canvas functions
function triggerCanvas(data){
	$('#overlay').html('');
	loadHtml(data);
	$('#overlay').css('top', $(document).scrollTop());
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

function loadVoting(data){
	$.ajax({
		url : data.getAttribute("data-url") + "?item_type=" + data.getAttribute("data-item-type") + "&voting_type=" + data.getAttribute("data-voting-type"),
		error : function(jqXHR, textStatus, errorThrown) {
			alert('There was a problem loading the requested content. Please try again later');
		},
		success : function(html, resultText) {
			$('#votingOverlay').html(html);
		}
	});
}

// voting canvas functions

function triggerVotingCanvas(data){
	$('#votingOverlay').html('');
	loadVoting(data);
	showVotingCanvas();
}

function showVotingCanvas(){
	$('#votingOverlayBlurr').fadeToggle();
	$('#votingOverlay').fadeToggle();
}

function hideVotingCanvas(){
	$('#votingOverlay').fadeOut();
	$('#votingOverlayBlurr').fadeOut();
}

$(document).ready(function() {



	// close canvas on pressing ESC
	$(document).keyup(function(e) {
		if (e.keyCode == 27) {
			hideCanvas();   
			hideVotingCanvas();
		}
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

	// set bookmark ! no popup ! straight to ajax action
	$('.toggle_bookmark').click(function(){
		set_bookmark($(this).data('bookmark'));
	});


	// globally enables bootstrap tooltips wherever configured
	$('[data-toggle="tooltip"]').tooltip()


	// user dob datepicker
	$('#datepicker').datepicker({
		viewMode: 'years'
	});

	$('.complaint').click(function(){
		triggerCanvas(this);
	});

	$('.trigger_share_voting').click(function(){
		triggerCanvas(this)
	});

	
	$('#new_voting').click(function(){
		triggerCanvas(this)
	});

	$('.new_image_item').click(function(){
		triggerCanvas(this)
	});
	
	$('#sign_in').click(function(){
		triggerCanvas(this)
	});

	$('.trigger_voting').click(function(){
		triggerVotingCanvas(this)
	});




	$('#votingOverlayBlurr').click(function(){
		hideVotingCanvas();
	});


});

$(window).load(function(){
	var calculatedNumberOfColumns = Math.floor(($('#v_tile_container').width()) / 225);
	
	// TODO: eventually to be replaced by isotope.js for sorting and filtering ..?
	// distribute tiles
	$('#v_tile_container').BlocksIt({
		numOfCol: calculatedNumberOfColumns,
		offsetX: 8,
		offsetY: 8,
		blockElement: '.grid'
	});

	// distribute tiles "you may also like"
	$('#v_tile_container_interesting').BlocksIt({
		numOfCol: calculatedNumberOfColumns,
		offsetX: 8,
		offsetY: 8,
		blockElement: '.grid'
	});
});
