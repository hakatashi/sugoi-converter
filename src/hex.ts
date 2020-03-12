export const encode = (data:Buffer) => {
	return data.toString('hex').toUpperCase();
};

export const decode = (text:string) => {
	if (text.match(/[^0-9a-f\s]/i)) {
		throw new Error('Invalid hex string');
	}

	const normalized = text.replace(/\s/g, '');

	if (normalized.length % 2 !== 0) {
		throw new Error('Input is not aligned into bytes')
	}

	return Buffer.from(normalized, 'hex');
};
