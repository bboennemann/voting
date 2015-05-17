$(document).ready(function() {
	$('.rate_star').click(function(){
		var index = $(this).data('index');
		$('#stars_' + index ).toggle('blind');
		$('#result_' + index ).toggle('blind');
	});
});