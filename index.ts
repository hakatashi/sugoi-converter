import $ = require('jquery');
import rot13 = require('./src/rot13');

interface Converter {
	decode: (text:string) => string,
	encode: (text:string) => string,
};

const converters:{[id:string]:Converter} = Object.create(null);

converters['rot13'] = rot13;

const elements = Object.create(null);

$(document).ready(() => {
	$('.textarea').on('keyup keypress keydown change click contextmenu paste', (event) => {
		if ($(event.target).data('converter') === 'plain') {
		}
	});
});
