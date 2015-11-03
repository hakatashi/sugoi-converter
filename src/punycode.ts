import punycode = require('punycode');

export const encode = (text) => {
	return punycode.encode(text);
};
export const decode = (text) => {
	return punycode.decode(text);
};
