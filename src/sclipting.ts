import sclipting = require('sclipting-escape');

export const encode = (data:Buffer) => {
	return sclipting.encode(data);
};

export const decode = (text:string) => {
	return sclipting.decode(text);
};
