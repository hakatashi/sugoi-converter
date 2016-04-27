export const encode = (data:Buffer) => {
	return data.toString('hex').toUpperCase();
};

export const decode = (text:string) => {
	return Buffer.from(text.replace(/\s/g, ''), 'hex');
};
