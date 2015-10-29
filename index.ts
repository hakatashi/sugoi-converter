import $ = require('jquery');

$(document).ready(() => {
	$('.textarea').on('keyup keypress keydown change click contextmenu paste', (event) => {
		if ($(event.target).is('.plain > .textarea')) {
			console.log($(event.target).val());
		}
	});
});
