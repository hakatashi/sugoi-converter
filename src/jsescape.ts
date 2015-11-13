// Spec: http://www.ecma-international.org/ecma-262/6.0/#sec-literals-string-literals
// Refer: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String#Escape_notation

// NOTE: This module is not well tested and do not use for real escaping/unescaping works.
//       It can be security risk.

import punycode = require('punycode');
import assert = require('assert');
import {ord, chr, zfill, startsWith} from './util'

const escapeChars:{[codePoint:number]:string} = Object.create(null);

escapeChars[ord('\'')] = '\\\'';
escapeChars[ord('\"')] = '\\"';
escapeChars[ord('\\')] = '\\\\';
escapeChars[ord('\b')] = '\\b';
escapeChars[ord('\f')] = '\\f';
escapeChars[ord('\n')] = '\\n';
escapeChars[ord('\r')] = '\\r';
escapeChars[ord('\t')] = '\\t';
escapeChars[ord('\v')] = '\\v';

const reverseEscapeChars:{[char:string]:number} = Object.create(null);
for (let key of Object.keys(escapeChars)) {
	reverseEscapeChars[escapeChars[parseInt(key)]] = parseInt(key);
}

// The goal of this function is to represent any valid string
// by ASCII printable characters only. Do not just use JSON.stringify().
export const encode = (data:Buffer) => {
	const string = data.toString('utf8');
	const codePoints = punycode.ucs2.decode(string);

	let text = '';

	for (let codePoint of codePoints) {
		// UTF-8 is only expressible of code points less than U+10FFFF
		assert(0 <= codePoint && codePoint <= 0x10FFFF);

		// Escape
		// Unused escape sequences: \0, \OOO

		// Special escape characters
		if (escapeChars[codePoint] !== undefined) {
			text += escapeChars[codePoint];
		}
		// ASCII printable chars
		else if (0x20 <= codePoint && codePoint <= 0x7E) {
			text += chr(codePoint);
		}
		// Expressive by \xXX
		else if (codePoint <= 0xFF) {
			text += `\\x${zfill(codePoint.toString(16), 2)}`;
		}
		// Expressive by \uXXXX
		else if (codePoint <= 0xFFFF) {
			text += `\\u${zfill(codePoint.toString(16), 4)}`;
		}
		// Then nice to have \u{XXXXX}
		else {
			text += `\\u{${codePoint.toString(16)}}`;
		}
	}

	return text;
};

// NOTE: JSON.parse() recongnizes only escaping by '\uXXXX'.
export const decode = (text:string):Buffer => {
	const codePoints:number[] = [];
	let remnant = text;
	let match:RegExpMatchArray;

	// The terms are derived from the spec. Read thoroughly.
	while (remnant.length > 0) {
		// SourceCharacter
	    if (
			// Not LineTerminator or backslash
			['\\', '\x0A', '\x0D', '\u2028', '\u2029'].indexOf(remnant[0]) === -1
		) {
			codePoints.push(ord(remnant[0]))
			remnant = remnant.slice(1);
			continue;
		}

		// \ EscapeSequence
		let escapeSequenceMatched = false;

		// CharacterEscapeSequence => SingleEscapeCharacter
		if (match = remnant.match(/^(\\['"\\bfnrtv])/)) {
			codePoints.push(reverseEscapeChars[match[1]]);
			remnant = remnant.slice(match[1].length);
			escapeSequenceMatched = true;
		}
	}

	throw new Error('not implemented');

	return new Buffer(0);
};
