chai = require 'chai'
jsescape = require '../src/jsescape'

{equalityWith} = require './util'

expect = chai.expect

describe 'jsescape', ->
	describe 'jsescape.encode', ->
		it 'basically works', ->
			# Just note. Coffescript doesn't support '\u{xxxxx}' and
			# '\udaae\udfbb' is just a '\u{bbbbb}'.
			expect jsescape.encode 'bbbBBB\b\b\b\xbb\ubbbb\udaae\udfbb'
			.to.be.a 'string'
			.and.equal 'bbbBBB\\b\\b\\b\\xbb\\ubbbb\\u{bbbbb}'

	describe 'jsescape.decode', ->
		# Not implemented yet
		it.skip 'basically works', ->
			expect jsescape.decode 'bbbBBB\\b\\b\\b\\xbb\\ubbbb\\u{bbbbb}'
			.to.satisfy equalityWith 'bbbBBB\b\b\b\xbb\ubbbb\uda6a\udeaa'
