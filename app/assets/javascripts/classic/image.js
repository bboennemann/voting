var imageBaseUrl = 'http://s3.amazonaws.com/votogenic/development/image_items/';
var votingId;
var itemCursor = 0;
var currentItem;
var currentItemId;
var previousItem;
var previousItemId;

$(document).ready(function() {

	votingId = $('#voting_id').attr('value');
	initialize_voting(votingId);

	$('.rate_star').click(function(){
		vote($(this).data('rating'));
	});

});

// TODO: needs to be post method!
function vote(value){
	$.ajax({
		url : '/classic_votings/' + votingId + '/image_items/' + currentItemId + '/vote_image_item.json?result=' + value,
		type : 'get',
		error : function(jqXHR, textStatus, errorThrown) {
			alert('There was a problem loading the requested content. Please try again later');
		},
		success : function(item, resultText) {
			currentItem = item
			getNextItem()
			// TODO: fill previous container
			$('#previous_image_container').fadeIn();
		}
	});

}

function initialize_voting(voting_id){
	$.ajax({
		url : '/votings/' + votingId + '/init.json',
		type : 'get',
		error : function(jqXHR, textStatus, errorThrown) {
			alert('There was a problem loading the requested content. Please try again later');
		},
		success : function(voting, resultText) {
			items = voting.items
			getNextItem();
			$('#initializing_wait_message').fadeOut();
		}
	});
}

function getNextItem(){
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
			
			$('#current_image').attr('src', '/assets/squares.gif');
			populate_current_image();
			populate_previsous_image();
		}
	});
}

function populate_previsous_image(){
	$('#previous_image').attr('src', imageBaseUrl + previousItemId + '/xs.jpg');
	$('#previous_image_score').text(previousItem.score);
	$('#previous_image_hits').text(previousItem.hits);
	$('#previous_image_container').fadeIn();
}

function populate_current_image(){
	$('#current_image').attr('src', imageBaseUrl + currentItemId + '/l.jpg');
}