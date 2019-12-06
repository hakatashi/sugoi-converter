// Be cool. Be Pythonic.

export function ord (char:string) {
	return char.codePointAt(0);
}

export function chr (codePoint:number) {
	return String.fromCodePoint(codePoint);
}

export function zfill (string:string, length:number) {
	const fillLength = Math.max(length - string.length, 0);
	return '0'.repeat(fillLength) + string;
}

//export const startsWith = require('starts-with');
//export const endsWith = require('ends-with');
