import {ord, chr} from './util'

const a = ord('a');
const z = ord('z');
const A = ord('A');
const Z = ord('Z');

// ROT-N
const rotN = (text:string, N:number) => {
	return text.replace(/[a-zA-Z]/g, (character) => {
		const codePoint = ord(character);

		if (a <= codePoint && codePoint <= z) {
			return chr(a + (codePoint - a + N) % 26);
		} else {
			return chr(A + (codePoint - A + N) % 26);
		}
	});
};

const rot13 = (text:string) => rotN(text, 13);

export = rot13;
