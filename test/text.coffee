chai = require 'chai'
text = require '../src/text'

{equalityWith} = require './util'

expect = chai.expect

EXAMPLES = [
# https://en.wikipedia.org/wiki/UTF-8#Examples
	encoded: '$'
	plain: '24'
,
	encoded: '¢'
	plain: 'C2A2'
,
	encoded: '€'
	plain: 'E282AC'
,
	encoded: '𐍈'
	plain: 'F0908D88'
]

describe 'text', ->
	describe 'text.encode', ->
		it 'basically works', ->
			for example in EXAMPLES
				expect text.encode new Buffer example.plain, 'hex'
				.to.be.a 'string'
				.and.equal example.encoded

	describe 'text.decode', ->
		it 'basically works', ->
			for example in EXAMPLES
				expect text.decode example.encoded
				.to.satisfy equalityWith new Buffer example.plain, 'hex'
