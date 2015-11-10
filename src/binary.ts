export const encode = (data:Buffer) => {
	let text = '';

	// Messy :puke:
	const arrayedData = [].slice.call(data);

	for (const byte of arrayedData) {
		text += ('00000000' + byte.toString(2)).slice(-8);
	}

	return text;
};

export const decode = (text:string) => {
	let bytes:number[] = [];

	// Remove white spaces
	text = text.replace(/\s/g, '');

	const match = text.match(/[^01]/);
	if (match) {
		throw new Error(`Invalid character: ${match[0]}`);
	}

	for (let ptr = 0; ptr < text.length; ptr += 8) {
		const octet = (text.substr(ptr, 8) + '00000000').slice(0, 8);
		const byte = parseInt(octet, 2);

		bytes.push(byte);
	}

	return new Buffer(bytes);
};
