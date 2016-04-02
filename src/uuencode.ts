import uuencode = require('@hakatashi/uuencode');

export const encode = (data:Buffer) => {
	return uuencode.encode(data);
};

export const decode = (text:string) => {
	return uuencode.decode(text);
};
