import unorm = require('unorm');

export const encode = (data:Buffer) => {
	return unorm.nfkd(data.toString('utf-8'));
};

export const decode = (text:string):Buffer => {
	throw new Error('NFKD cannot be decoded');
};
