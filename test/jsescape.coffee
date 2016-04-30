chai = require 'chai'
jsescape = require '../src/jsescape'

{equalityWith} = require './util'

expect = chai.expect

describe 'jsescape', ->
	describe 'jsescape.encode', ->
		it 'basically works', ->
			# Just note. Coffescript doesn't support '\u{xxxxx}' and
			# '\udaae\udfbb' is just a '\u{bbbbb}'.
			expect jsescape.encode new Buffer 'bbbBBB\b\b\b\xbb\ubbbb\udaae\udfbb'
			.to.be.a 'string'
			.and.equal 'bbbBBB\\b\\b\\b\\xbb\\ubbbb\\u{bbbbb}'

	describe 'jsescape.decode', ->
		# Not implemented yet
		it 'basically works', ->
			expect jsescape.decode 'bbbBBB\\b\\b\\b\\xbb\\ubbbb\\u{bbbbb}'
			.to.satisfy equalityWith 'bbbBBB\b\b\b\xbb\ubbbb\udaae\udfbb'

		it 'recognizes legacy octal escape characters', ->
			expect jsescape.decode '\\0\\3\\7\\26\\02\\411\\711\\021\\347'
			.to.satisfy equalityWith '\0\x03\x07\x16\x02\x211\x391\x11\xe7'

		it 'recognize NonEscapeCharacter as it is', ->
			expect jsescape.decode '\\Q\\y\\o\\あ\\亜'
			.to.satisfy equalityWith 'Qyoあ亜'

		it 'recognize LineContinuation sequence', ->
			expect jsescape.decode 'bbb\\\nbbb'
			.to.satisfy equalityWith 'bbb\nbbb'

		it 'throws error when invalid escape sequence is supplied', ->
			expect -> jsescape.decode '\\xZZ'
			.to.throw SyntaxError

			expect -> jsescape.decode '\\xf'
			.to.throw SyntaxError

			expect -> jsescape.decode '\\u10XX'
			.to.throw SyntaxError

			expect -> jsescape.decode '\\u271'
			.to.throw SyntaxError

			expect -> jsescape.decode '\\u{}'
			.to.throw SyntaxError

			expect -> jsescape.decode '\\u{110000}'
			.to.throw SyntaxError

			expect -> jsescape.decode '\\u{EECA008}'
			.to.throw SyntaxError

			expect -> jsescape.decode 'bbb\\\\\nbbb'
			.to.throw SyntaxError
