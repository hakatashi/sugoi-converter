require('core-js/fn/string/code-point-at');
require('core-js/fn/string/from-code-point');

export function ord (char:string) {
	return char.codePointAt(0);
}

export function chr (codePoint:number) {
	return String.fromCodePoint(codePoint);
}
