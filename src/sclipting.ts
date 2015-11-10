import assert = require('assert');

export const encode = (data:Buffer) => {
	let text = '';

	// Iterate over each three octets
	for (let ptr = 0; ptr < data.length; ptr += 3) {
		const bytes = data.slice(ptr, ptr + 3);
		let remnant = '';

		assert(1 <= bytes.length && bytes.length <= 3);

		if (bytes.length === 1) {
			remnant = String.fromCodePoint(0xAC00 + (bytes[0] << 4));
		} else if (bytes.length === 2) {
			remnant = String.fromCodePoint(0xAC00 + (bytes[0] << 4) + (bytes[1] >> 4));
			remnant += String.fromCodePoint(0xBC00 + (bytes[1] & 0x0F));
		} else {
			remnant = String.fromCodePoint(0xAC00 + (bytes[0] << 4) + (bytes[1] >> 4));
			remnant += String.fromCodePoint(0xAC00 + ((bytes[1] & 0x0F) << 8) + bytes[2]);
		}

		text += remnant;
	}

	return text;
};

export const decode = (text:string) => {
	let bytes:number[] = [];

	// Remove white spaces
	text = text.replace(/\s/g, '');

	let ptr:number;
	for (ptr = 0; ptr < text.length; ) {
		const codePoint = text.codePointAt(ptr);
		ptr += String.fromCodePoint(codePoint).length;

		if (codePoint < 0xAC00 || 0xBC00 <= codePoint) {
			throw new Error(`Invalid character: ${String.fromCodePoint(codePoint)}`);
		}

		// remaining byte is 1
		if (text.length <= ptr) {
			// NOTE: This check can be skipped
			if ((codePoint & 0x0F) !== 0) {
				throw new Error(`Invalid character: ${String.fromCodePoint(codePoint)}`);
			}

			bytes.push((codePoint - 0xAC00) >> 4);
			break;
		}

		const codePoint2 = text.codePointAt(ptr);
		ptr += String.fromCodePoint(codePoint2).length;

		if (0xAC00 <= codePoint2 && codePoint2 < 0xBC00) {
			bytes.push((codePoint - 0xAC00) >> 4);
			bytes.push((((codePoint - 0xAC00) & 0x0F) << 4) | ((codePoint2 - 0xAC00) >> 8));
			bytes.push((codePoint2 - 0xAC00) & 0xFF);
		} else if (0xBC00 <= codePoint2 && codePoint2 < 0xBC0F) {
			bytes.push((codePoint - 0xAC00) >> 4);
			bytes.push((((codePoint - 0xAC00) & 0x0F) << 4) | (codePoint2 - 0xBC00));
			break;
		} else {
			throw new Error(`Invalid character: ${String.fromCodePoint(codePoint2)}`);
		}
	}

	// This check can be skipped
	if (ptr < text.length) {
		throw new Error(`Excess characters after: ${text[ptr]}`);
	}

	return new Buffer(bytes);
};
