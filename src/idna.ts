import uts46 = require('idna-uts46');

export const encode = (data:Buffer) => {
	return uts46.toAscii(data.toString('utf-8'), {
		transitional: false,
	})
};

export const decode = (text:string) => {
	return Buffer.from(uts46.toUnicode(text), 'utf-8')
};
