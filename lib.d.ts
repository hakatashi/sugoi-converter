declare module "ascii85" {
	export function encode(data: string | Buffer, options?: {
		table?: string[],
		delimiter?: boolean,
		groupSpace?: boolean,
	}): string;

	export function decode(str: string | Buffer, table?: string[]): string;

	export interface Ascii85 {
		encode(data: string | Buffer, options?: {
			table?: string[],
			delimiter?: boolean,
			groupSpace?: boolean,
		}): string;

		decode(str: string | Buffer, table?: string[]): string;
	}

	export var ZeroMQ:Ascii85;
	export var PostScript:Ascii85;
}

declare module "starts-with" {
	function startsWith(string: string | string[], prefix: string | string[]): boolean;
	export = startsWith;
}

declare module "ends-with" {
	function endsWith(string: string | string[], prefix: string | string[]): boolean;
	export = endsWith;
}

declare module "html-entities" {
	class Entities {
		encode(string: string): string;
		encodeNonUTF(string: string): string;
		encodeNonASCII(string: string): string;
		decode(string: string): string;
	}

	export class XmlEntities extends Entities {}
	export class Html4Entities extends Entities {}
	export class Html5Entities extends Entities {}
	export class AllHtmlEntities extends Entities {}
}

declare module "quoted-printable" {
	export function encode(input: string): string;
	export function decode(text: string): string;
}

declare module "uuencode" {
	export function encode(data: string | Buffer): string;
	export function decode(text: string | Buffer): Buffer;
}

declare module "lodash.invert" {
	function invert(object: {[key: string]: string}): {[key: string]: string};
	export = invert;
}

declare module "regenerate" {
	type RegenerateValue = number | string;

	interface Regenerate {
		add(values: RegenerateValue[]): Regenerate;
		add(...values: RegenerateValue[]): Regenerate;
		remove(values: RegenerateValue[]): Regenerate;
		remove(...values: RegenerateValue[]): Regenerate;
		addRange(start: RegenerateValue, end: RegenerateValue): Regenerate;
		removeRange(start: RegenerateValue, end: RegenerateValue): Regenerate;
		intersection(codepoints: RegenerateValue[] | Regenerate): Regenerate;
		contains(value: RegenerateValue): boolean;
		clone(): Regenerate;
		toString(options?: {bmpOnly?: boolean}): string;
		toRegExp(flags?: string): RegExp;
		valueOf(): number[];
		toArray(): number[];
	}

	function regenerate(...values: RegenerateValue[]): Regenerate;

	export = regenerate;
}

declare module "node-emoji" {
	export var emoji: {[name: string]: string};
	export function _get(emoji: string): string;
	export function get(emoji: string): string;
	export function which(emoji_code: string): string;
	export function emojify(str: string): string;
}
