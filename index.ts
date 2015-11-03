import $ = require('jquery');
import rot13 = require('./src/rot13');

interface Engine {
	decode: (text:string) => string,
	encode: (text:string) => string,
};

const $forms:{[id:string]:JQuery} = Object.create(null);
const engines:{[id:string]:Engine} = Object.create(null);

engines['rot13'] = rot13;

$(document).ready(() => {
	$('.textarea').each((index, element) => {
		$forms[$(element).data('converter')] = $(element);
	});

	for (var id in $forms) {
		// Enclose `id` into closure... since TypeScript doesn't support
		// block closure transpilings
		((id) => {
			const $form = $forms[id];

			$form.on('keyup keypress keydown change click contextmenu paste', (event) => {
				console.log(id);
			});
		})(id);
	}
});
