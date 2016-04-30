chai = require 'chai'
unicode = require '../src/unicode'

{equalityWith} = require './util'

expect = chai.expect

describe 'unicode', ->
	describe 'unicode.encode', ->
		it 'basically works', ->
			expect unicode.encode new Buffer '1②𝟛'
			.to.be.a 'string'
			.and.equal 'U+0031 U+2461 U+1D7DB'

	describe 'unicode.decode', ->
		it 'basically works', ->
			expect unicode.decode 'U+0031 U+2461 U+1D7DB'
			.to.satisfy equalityWith '1②𝟛'
