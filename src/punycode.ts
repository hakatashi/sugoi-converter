import punycode = require('punycode');

export const encode = (text:string) => {
	return punycode.encode(text);
};
export const decode = (text:string) => {
	return punycode.decode(text);
};
