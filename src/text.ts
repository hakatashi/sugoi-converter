export const encode = (data:Buffer) => {
	return data.toString('utf8');
};

export const decode = (text:string) => {
	return new Buffer(text, 'utf8');
};
