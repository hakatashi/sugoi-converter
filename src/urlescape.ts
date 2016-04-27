export const encode = (data:Buffer) => {
	return encodeURIComponent(data.toString('utf-8'));
};

export const decode = (text:string) => {
	return Buffer.from(decodeURIComponent(text), 'utf-8');
};
