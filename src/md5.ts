import crypto = require('crypto');

export const encode = (data:Buffer) => {
	return crypto.createHash('md5').update(data).digest('hex');
};

export const decode = (text:string):Buffer => {
	throw new Error('MD5 cannot be decoded');
};
