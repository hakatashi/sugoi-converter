import punycode = require('punycode');

export const encode = (data:Buffer) => {
	const text = data.toString('utf-8');
	const codePoints = punycode.ucs2.decode(text);
	const codeStrings:string[] = [];

	for (const codePoint of codePoints) {
		const hex = codePoint.toString(16).toUpperCase();
		let codeString:string;

		if (hex.length > 4) {
			codeString = `U+${hex}`;
		} else {
			codeString = `U+${('0000' + hex).slice(-4)}`;
		}

		codeStrings.push(codeString);
	}

	return codeStrings.join(' ');
};

export const decode = (text:string) => {
	const codeStrings = text.split(' ');
	const codePoints:number[] = [];

	for (let codeString of codeStrings) {
		codeString = codeString.trim();
		if (codeString.length === 0) {
			continue;
		}

		if (codeString.slice(0, 2) === 'U+') {
			codeString = codeString.slice(2);
		}

		const codePoint = parseInt(codeString, 16);

		if (isNaN(codePoint)) {
			throw new Error(`Invalid code point: ${codeString}`);
		}

		codePoints.push(codePoint);
	}

	const unicodes = punycode.ucs2.encode(codePoints);

	return Buffer.from(unicodes, 'utf-8');
};
