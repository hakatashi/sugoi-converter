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

	for (let ptr = 0; ptr < text.length; ptr += 8) {
		const octet = (text.substr(ptr, 8) + '00000000').slice(0, 8);
		const byte = parseInt(octet, 2);

		if (Number.isNaN(byte)) {
			throw new Error(`Invalid octet: ${octet}`);
		}

		bytes.push(byte);
	}

	return new Buffer(bytes);
};
