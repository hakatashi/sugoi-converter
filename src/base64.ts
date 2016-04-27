export const encode = (data:Buffer) => {
	return data.toString('base64');
};

export const decode = (text:string) => {
	return Buffer.from(text, 'base64');
};
