chai = require 'chai'
base64 = require '../src/base64'

{equalityWith} = require './util'

expect = chai.expect

# https://en.wikipedia.org/wiki/Base64#Examples

EXAMPLE_PLAIN = '
	Man is distinguished, not only by his reason, but by this singular passion from
	other animals, which is a lust of the mind, that by a perseverance of delight
	in the continued and indefatigable generation of knowledge, exceeds the short
	vehemence of any carnal pleasure.
'

EXAMPLE_BASE64 = '
	TWFuIGlzIGRpc3Rpbmd1aXNoZWQsIG5vdCBvbmx5IGJ5IGhpcyByZWFzb24sIGJ1dCBieSB0aGlz
	IHNpbmd1bGFyIHBhc3Npb24gZnJvbSBvdGhlciBhbmltYWxzLCB3aGljaCBpcyBhIGx1c3Qgb2Yg
	dGhlIG1pbmQsIHRoYXQgYnkgYSBwZXJzZXZlcmFuY2Ugb2YgZGVsaWdodCBpbiB0aGUgY29udGlu
	dWVkIGFuZCBpbmRlZmF0aWdhYmxlIGdlbmVyYXRpb24gb2Yga25vd2xlZGdlLCBleGNlZWRzIHRo
	ZSBzaG9ydCB2ZWhlbWVuY2Ugb2YgYW55IGNhcm5hbCBwbGVhc3VyZS4=
'.replace /[ ]/g, ''

describe 'base64', ->
	describe 'base64.encode', ->
		it 'basically works', ->
			expect base64.encode new Buffer 'Man', 'ascii'
			.to.be.a 'string'
			.and.equal 'TWFu'

			expect base64.encode new Buffer EXAMPLE_PLAIN, 'ascii'
			.to.be.a 'string'
			.and.equal EXAMPLE_BASE64

	describe 'base64.decode', ->
		it 'basically works', ->
			expect base64.decode 'TWFu'
			.to.satisfy equalityWith 'Man'

			expect base64.decode EXAMPLE_BASE64
			.to.satisfy equalityWith EXAMPLE_PLAIN

		it 'can decode some invalid base64s', ->
			# Excess bit for zerofill part
			expect base64.decode 'TWF='
			.to.satisfy equalityWith 'Ma'

			# Length of base64 string is not multiple of 4
			expect base64.decode 'TWF'
			.to.satisfy equalityWith 'Ma'

			# Invalid characters
			expect base64.decode '!#T$W%&%F%u^|'
			.to.satisfy equalityWith 'Man'
