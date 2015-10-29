export function ord (char:string) {
	return char.codePointAt(0);
}

export function chr (codePoint) {
	return String.fromCodePoint(codePoint);
}
