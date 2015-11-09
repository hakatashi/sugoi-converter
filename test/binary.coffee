chai = require 'chai'
binary = require '../src/binary'

expect = chai.expect

describe 'binary', ->
	describe 'binary.encode', ->
		it 'works', ->
			text = binary.encode new Buffer [0b11001010, 0b00110101]
			expect(text).to.be.a 'string'
			expect(text).to.equal '1100101000110101'
