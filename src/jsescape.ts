// Spec: http://www.ecma-international.org/ecma-262/6.0/#sec-literals-string-literals
// Refer: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String#Escape_notation

// NOTE: This module is not well tested and do not use for real escaping/unescaping works.
//       It can be security risk.

import punycode = require('punycode');
import assert = require('assert');
import {ord, chr, zfill} from './util'

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

		console.log(data.toString('hex'), string, codePoint);

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

// NOTE: JSON.parse() only supports escaping by '\uXXXX'.
export const decode = (text:string):Buffer => {
	throw new Error('not implemented');
};
