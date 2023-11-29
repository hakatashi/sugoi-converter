import * as unorm from 'unorm';

export const encode = (data:Buffer) => {
	return unorm.nfc(data.toString('utf-8'));
};

export const decode = (text:string):Buffer => {
	throw new Error('NFC cannot be decoded');
};
