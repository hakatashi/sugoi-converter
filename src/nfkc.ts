import unorm = require('unorm');

export const encode = (data:Buffer) => {
	return unorm.nfkc(data.toString('utf-8'));
};

export const decode = (text:string):Buffer => {
	throw new Error('NFKC cannot be decoded');
};
