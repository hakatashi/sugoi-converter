import punycode = require('punycode');

export const encode = (data:Buffer) => {
	return punycode.encode(data.toString('utf-8'));
};

export const decode = (text:string) => {
	return Buffer.from(punycode.decode(text), 'utf-8');
};
