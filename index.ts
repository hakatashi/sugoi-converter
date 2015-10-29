import $ = require('jquery');
import rot13 = require('./src/rot13');

$(document).ready(() => {
	$('.textarea').on('keyup keypress keydown change click contextmenu paste', (event) => {
		if ($(event.target).is('.plain > .textarea')) {
			console.log(rot13($(event.target).val()));
		}
	});
});
