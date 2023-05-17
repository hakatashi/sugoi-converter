require('./analytics');

import qs = require('querystring');

import hex = require('./src/hex');
import md5 = require('./src/md5');
import nfc = require('./src/nfc');
import text = require('./src/text');
import sha1 = require('./src/sha1');
import nfkc = require('./src/nfkc');
import idna = require('./src/idna');
import rot13 = require('./src/rot13');
import rot47 = require('./src/rot47');
import base64 = require('./src/base64');
import binary = require('./src/binary');
import unicode = require('./src/unicode');
import ascii85 = require('./src/ascii85');
import punycode = require('./src/punycode');
import jsescape = require('./src/jsescape');
import uuencode = require('./src/uuencode');
import urlescape = require('./src/urlescape');
import sclipting = require('./src/sclipting');
import htmlescape = require('./src/htmlescape');
import quotedprintable = require('./src/quotedprintable');

require('zepto');
require('zepto/event');

interface Engine {
	decode: (text:string) => Buffer,
	encode: (text:Buffer) => string,
};

const $forms:{[id:string]:ZeptoCollection} = Object.create(null);
const engines:{[id:string]:Engine} = Object.create(null);

engines['hex'] = hex;
engines['md5'] = md5;
engines['nfc'] = nfc;
engines['text'] = text;
engines['sha1'] = sha1;
engines['nfkc'] = nfkc;
engines['idna'] = idna;
engines['rot13'] = rot13;
engines['rot47'] = rot47;
engines['base64'] = base64;
engines['binary'] = binary;
engines['unicode'] = unicode;
engines['ascii85'] = ascii85;
engines['punycode'] = punycode;
engines['jsescape'] = jsescape;
engines['uuencode'] = uuencode;
engines['urlescape'] = urlescape;
engines['sclipting'] = sclipting;
engines['htmlescape'] = htmlescape;
engines['quotedprintable'] = quotedprintable;

$(document).ready(() => {
	$('.textarea').each((index, element) => {
		$forms[$(element).data('converter')] = $(element);
		return true;
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
						$form.siblings('.error').text(`Decode Error: ${error.message}`).show();
						return;
					}

					$form.siblings('.error').empty().hide();
				}

				for (let targetId in $forms) {
					if (targetId !== id && engines[targetId]) {
						try {
							encoded = engines[targetId].encode(raw);
						} catch (error) {
							$forms[targetId].siblings('.error').text(`Encode Error: ${error.message}`).show();
							return;
						}

						$forms[targetId].siblings('.error').empty().hide();
						$forms[targetId].val(encoded);
					}
				}
			});
		})(id);
	}

	const params = qs.parse(window.location.search.substr(1));

	const text = (() => {
		const textParam = params['text'];

		if (typeof textParam === 'string') {
			return textParam;
		} else if (typeof textParam === 'object') {
			return textParam[0];
		} else {
			return 'Let\'s say “Sugoi™!!!!”';
		}
	})();

	const field = (() => {
		const fieldParam = params['field'];

		if (typeof fieldParam === 'string') {
			return fieldParam;
		} else if (typeof fieldParam === 'object') {
			return fieldParam[0];
		} else {
			return 'text';
		}
	})();

	const $form = (() => {
		if (typeof $forms[field] === 'object') {
			return $forms[field];
		} else {
			return $forms['text'];
		}
	})()

	$form.text(text).change();
});
