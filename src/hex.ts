export const encode = (data:Buffer) => {
	return data.toString('hex').toUpperCase();
};

export const decode = (text:string) => {
	if (text.match(/[^0-9a-f\s]/i)) {
		throw new Error('Invalid hex string');
	}

	return new Buffer(text.replace(/\s/g, ''), 'hex');
};
