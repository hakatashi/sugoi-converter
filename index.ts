require('core-js');

import $ = require('jquery');
import hex = require('./src/hex');
import md5 = require('./src/md5');
import text = require('./src/text');
import sha1 = require('./src/sha1');
import rot13 = require('./src/rot13');
import base64 = require('./src/base64');
import binary = require('./src/binary');
import unicode = require('./src/unicode');
import punycode = require('./src/punycode');
import urlescape = require('./src/urlescape');
import sclipting = require('./src/sclipting');

interface Engine {
	decode: (text:string) => Buffer,
	encode: (text:Buffer) => string,
};

const $forms:{[id:string]:JQuery} = Object.create(null);
const engines:{[id:string]:Engine} = Object.create(null);

engines['hex'] = hex;
engines['md5'] = md5;
engines['text'] = text;
engines['sha1'] = sha1;
engines['rot13'] = rot13;
engines['base64'] = base64;
engines['binary'] = binary;
engines['unicode'] = unicode;
engines['punycode'] = punycode;
engines['urlescape'] = urlescape;
engines['sclipting'] = sclipting;

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
				let raw:Buffer, encoded:string;

				if (!engines[id]) {
					return;
				} else {
					try {
						raw = engines[id].decode(text);
					} catch (error) {
						$form.siblings('.error').text('Decode Error: ' + error.message).show();
						return;
					}

					$form.siblings('.error').empty().hide();
				}

				for (let targetId in $forms) {
					if (targetId !== id && engines[targetId]) {
						try {
							encoded = engines[targetId].encode(raw);
						} catch (error) {
							$forms[targetId].siblings('.error').text('Encode Error: ' + error.message).show();
							return;
						}

						$forms[targetId].siblings('.error').empty().hide();
						$forms[targetId].val(encoded);
					}
				}
			});
		})(id);
	}

	$forms['text'].text('Let\'s say “Sugoi™!!!!”').change();
});
