require('core-js/fn/string/code-point-at');

import assert = require('assert');
import sclipting = require('sclipting-escape');
import {ord, chr} from './util'

export const encode = (data:Buffer) => {
	return sclipting.encode(data);
};

export const decode = (text:string) => {
	return sclipting.decode(text);
};
