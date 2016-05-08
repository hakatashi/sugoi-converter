import quotedPrintable = require('quoted-printable');

export const encode = (data:Buffer) => {
	return quotedPrintable.encode(data.toString('binary'));
};

export const decode = (text:string) => {
	return Buffer.from(quotedPrintable.decode(text), 'binary');
};
