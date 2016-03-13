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
