var imageBaseUrl = 'http://s3.amazonaws.com/votogenic/production/image_items/';
var votingId;
var itemCursor = 0;
var currentItem = null;
var currentItemId = null;
var previousItem = null;
var previousItemId = null;
var item = null;
var items = null;
var imageSize = 's';

$(document).ready(function() {

	if($( window ).width() > 350) imageSize = 'm';
	if($( window ).width() > 800) imageSize = 'l';
	if($( window ).width() > 1200) imageSize = 'original';


	$('.rate_star').click(function(){
		vote($(this).data('rating'));
	});

	votingId = $('#voting_id').attr('value');
	initialize_voting(votingId);

	$('.complaint').off('click');
	$('.set_bookmark').off('click');
	$('.bookmark_remove').off('click');
	$('.trigger_share_voting').off('click');
	$('.new_image_item').off('click');

	$('.complaint').click(function(){
		triggerCanvas(this);		
	});

	// set bookmark ! no popup ! straight to ajax action
	$('.toggle_bookmark').click(function(){
		set_bookmark($(this).data('bookmark'));
	});

	$('.trigger_share_voting').click(function(){
		triggerCanvas(this)
	});

	$('.new_image_item').click(function(){
		triggerCanvas(this)
	});

	$('#current_image').mouseenter(function(){
		$('.v_current_item_actions').fadeIn();
		show_current_item_description();
	});

	$('.rate_star').mouseover(function(){
		$('.v_current_item_actions').fadeOut();
		$('#current_item_description').fadeOut();
	});

	$('#voting_context').mouseover(function(){
		$('.v_current_item_actions').fadeOut();
		$('#current_item_description').fadeOut();
	});

	$('#current_item_description').mouseover(function(){
		$('.v_current_item_actions').fadeOut();
		$('#current_item_description').fadeOut();
	});


	

});

function show_current_item_description(){
	if(currentItem.description != null){
		$('#current_item_description').text(currentItem.description);
		$('#current_item_description').fadeIn();
	}
}


function initialize_voting(votingId){
	$.ajax({
		url : '/votings/' + votingId + '/init.json',
		type : 'get',
		error : function(jqXHR, textStatus, errorThrown) {
			alert('There was a problem loading the requested content. Please try again later');
		},
		success : function(voting, resultText) {
			items = voting.items
			$('#initializing_wait_message').fadeOut();
			getNextItem();
		}
	});
}

// TODO: needs to be post method!
function vote(value){
	$('#stars').fadeOut();
	$.ajax({
		url : '/classic_votings/' + votingId + '/image_items/' + currentItemId + '/vote_image_item.json?result=' + value,
		type : 'get',
		error : function(jqXHR, textStatus, errorThrown) {
			alert('There was a problem loading the requested content. Please try again later');
		},
		success : function(item, resultText) {
			currentItem = item;
			if(items.length <= itemCursor){
				previousItemId = currentItemId;
				previousItem = currentItem;
				display_voting_over();
			}else{
				getNextItem();
			}
		}
	});

}

function getNextItem(){
	$('#current_image').attr('src', '/assets/squares.gif');
	previousItemId = currentItemId;
	currentItemId = items[itemCursor];
	$.ajax({
		url : '/image_items/' + currentItemId + '.json',
		type : 'get',
		error : function(jqXHR, textStatus, errorThrown) {
			alert('There was a problem loading the requested content. Please try again later');
		},
		success : function(item, resultText) {
			previousItem = currentItem;
			currentItem = item;

			itemCursor++;
			
			populate_current_image();
			populate_previous_image();
		}
	});
}

function populate_previous_image(){
	
	$('#previous_image').attr('src', imageBaseUrl + previousItemId + '/xs.jpg');
	$('#previous_image_score').text(previousItem.score);
	$('#previous_image_hits').text(previousItem.hits);
	$('#previous_image_container').fadeIn();

	if(previousItem.already_voted == true){
		$('#already_voted').hide();
		$('#already_voted').show( "bounce", { times: 3 }, "slow" );
	}else{
		$('#already_voted').hide();
		$('#current_image').effect( "transfer", { to: $('#previous_image') }, 500 );
	}
}

function populate_current_image(){	
	$('#current_image').hide();
	$('#current_image').attr('src', imageBaseUrl + currentItemId + '/' + imageSize + '.jpg');
	$("#trigger_complaint").attr('data-url', '/complaints/new?item_type=image_item&item_id=' + currentItemId + '&');
	$('#stars').fadeIn();
	set_website_url();
	$('#current_image').fadeIn();
}

function display_voting_over(){
	$('#current_image').fadeOut();	
	$('#stars').fadeOut();
	populate_previous_image();
	$('#done_voting').fadeIn();
}

function set_website_url(){
	if(currentItem.website_url == null){
		$('#item_website_url').fadeOut();
	}else{
		$('#item_website_url').attr('href', currentItem.website_url);
		$('#item_website_url').fadeIn();
	}
}