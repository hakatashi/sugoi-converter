import * as bs58 from 'bs58';

export const encode = (data:Buffer) => {
	return bs58.encode(data);
};

export const decode = (text:string) => {
	return Buffer.from(bs58.decode(text));
};
