import ascii85 = require('ascii85');

const encoder = ascii85.PostScript;

export const encode = (data:Buffer) => {
	return encoder.encode(data);
};

export const decode = (text:string) => {
	return Buffer.from(encoder.decode(text), 'binary');
};
