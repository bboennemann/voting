var imageBaseUrl = 'http://s3.amazonaws.com/votogenic/production/image_items/';
var votingId;
var itemCursor = 0;
var currentItem = null;
var currentItemId = null;
var previousItem = null;
var previousItemId = null;
var item = null;
var items = null;

$(document).ready(function() {

	$('.rate_star').click(function(){
		vote($(this).data('rating'));
	});

	votingId = $('#voting_id').attr('value');
	initialize_voting(votingId);

});


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
	if(previousItem.already_voted == true){
		$('#already_voted').show();
	}else{
		$('#already_voted').hide();
	}
	$('#previous_image').attr('src', imageBaseUrl + previousItemId + '/xs.jpg');
	$('#previous_image_score').text(previousItem.score);
	$('#previous_image_hits').text(previousItem.hits);
	$('#previous_image_container').fadeIn();
}

function populate_current_image(){
	$('#current_image').attr('src', imageBaseUrl + currentItemId + '/l.jpg');
	$('#stars').fadeIn();
}

function display_voting_over(){
	$('#current_image').fadeOut();	
	$('#stars').fadeOut();
	populate_previous_image();
	$('#done_voting').fadeIn();
}