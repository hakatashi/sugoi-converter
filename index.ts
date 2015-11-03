import $ = require('jquery');
import rot13 = require('./src/rot13');
import punycode = require('./src/punycode');

interface Engine {
	decode: (text:string) => string,
	encode: (text:string) => string,
};

const $forms:{[id:string]:JQuery} = Object.create(null);
const engines:{[id:string]:Engine} = Object.create(null);

engines['rot13'] = rot13;
engines['punycode'] = punycode;

$(document).ready(() => {
	$('.textarea').each((index, element) => {
		$forms[$(element).data('converter')] = $(element);
	});

	for (var id in $forms) {
		// Let enclose `id` into closure... since TypeScript doesn't support
		// block closure transpilings
		((id:string) => {
			const $form = $forms[id];

			$form.on('keyup keypress keydown change click contextmenu paste', (event) => {
				const text = $form.val();
				let plainText:string, encodedText:string;

				if (id === 'plain') {
					plainText = text;
				} else {
					if (!engines[id]) {
						return;
					} else {
						try {
							plainText = engines[id].decode(text);
						} catch (error) {
							$form.siblings('.error').text('Decode Error: ' + error.message);
							return;
						}

						$form.siblings('.error').empty();
						$forms['plain'].val(plainText);
					}
				}

				for (var targetId in $forms) {
					if (targetId !== 'plain' && targetId !== id && engines[targetId]) {
						try {
							encodedText = engines[targetId].encode(plainText);
						} catch (error) {
							$forms[targetId].siblings('.error').text('Encode Error: ' + error.message);
							return;
						}

						$forms[targetId].siblings('.error').empty();
						$forms[targetId].val(encodedText);
					}
				}
			});
		})(id);
	}
});
