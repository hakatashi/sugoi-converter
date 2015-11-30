import {ord, chr} from './util'

const codeRangeStart = ord('!');
const codeRangeEnd = ord('~');

// ROT-N
const rot47 = (text:string) => {
	return text.replace(/[!-~]/g, (character) => {
		const codePoint = ord(character);
		return chr(codeRangeStart + (codePoint - codeRangeStart + 47) % 94);
	});
};

export const encode = (data:Buffer) => {
	return rot47(data.toString('utf-8'));
};

export const decode = (text:string) => {
	return new Buffer(rot47(text), 'utf-8');
};
