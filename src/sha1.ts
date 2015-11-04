import crypto = require('crypto');

export const encode = (data:Buffer) => {
	return crypto.createHash('sha1').update(data).digest('hex');
};

export const decode = (text:string):Buffer => {
	throw new Error('SHA-1 cannot be decoded');
};
