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
	
	$('#new_voting').click(function(){
		$('#overlay').html('');
		loadHtml(this);
		showCanvas();
	});

	$('#trigger_overlay').click(function(){
		$('#overlay').html('');
		loadHtml(this);
		showCanvas();
	});
	
	$('#sign_in').click(function(){
		$('#overlay').html('');
		loadHtml(this);
		showCanvas();
	});
	

	$('#overlayBlurr').click(function(){
		hideCanvas();
	});

	$(document).keyup(function(e) {
		if (e.keyCode == 27) hideCanvas();   // esc
	});
	
});
