chai = require 'chai'
binary = require '../src/binary'

{equalityWith} = require './util'

expect = chai.expect

describe 'binary', ->
	describe 'binary.encode', ->
		it 'basically works', ->
			expect binary.encode new Buffer [0b11001010, 0b00110101]
			.to.be.a 'string'
			.and.equal '1100101000110101'

	describe 'binary.decode', ->
		it 'basically works', ->
			expect binary.decode '1010010100001111'
			.to.satisfy equalityWith [0b10100101, 0b00001111]

		it 'ignores any whitespace characters', ->
			expect binary.decode '11001010 01100110 10010010'
			.to.satisfy equalityWith [0b11001010, 0b01100110, 0b10010010]

			expect binary.decode ' 001 01\t01 011   10 0\n 101 '
			.to.satisfy equalityWith [0b00101010, 0b11100101]

		it 'pads with zero when octet is insufficient', ->
			expect binary.decode '0101110010011'
			.to.satisfy equalityWith [0b01011100, 0b10011000]

		it 'throws error when invalid character is supplied', ->
			expect -> binary.decode '010110a0'
			.to.throw Error

			expect -> binary.decode 'l0ll0ll0'
			.to.throw Error
