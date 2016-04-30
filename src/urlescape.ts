export const encode = (data:Buffer) => {
	return encodeURIComponent(data.toString('utf-8'));
};

export const decode = (text:string) => {
	return new Buffer(decodeURIComponent(text), 'utf-8');
};
