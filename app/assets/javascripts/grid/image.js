var index;
var currentItemId;

$(document).ready(function() {

	$('.rate_star').click(function(){
		currentItemId = $(this).data('item');
		index = $(this).data('index');
		vote($(this).data('rating'));
	});
});


// TODO: needs to be post method!
function vote(value){
	$.ajax({
		url : '/grid_votings/' + votingId + '/image_items/' + currentItemId + '/vote_image_item.json?result=' + value,
		type : 'get',
		error : function(jqXHR, textStatus, errorThrown) {
			alert('There was a problem loading the requested content. Please try again later');
		},
		success : function(item, resultText) {
			
			$('#stars_' + index ).toggle('blind');
			populate_current_image(item, index);
			$('#result_' + index ).toggle('blind');
		}
	});

}


function populate_current_image(item, index){	
	$('#grid_image_score_' + index).text(item.score);
	$('#grid_image_hits_' + index).text(item.hits);
/*
	if(previousItem.already_voted == true){
		$('#already_voted').hide();
		$('#already_voted').show( "bounce", { times: 3 }, "slow" );
	}else{
		$('#already_voted').hide();
		$('#current_image').effect( "transfer", { to: $('#previous_image') }, 500 );
	}
	*/
}
