chai = require 'chai'
binary = require '../src/binary'

expect = chai.expect

describe 'binary', ->
	describe 'binary.encode', ->
		it 'basically works', ->
			text = binary.encode new Buffer [0b11001010, 0b00110101]

			expect text
			.to.be.a 'string'
			.and.equal '1100101000110101'

	describe 'binary.decode', ->
		it 'basically works', ->
			buffer = binary.decode '1010010100001111'

			expect buffer
			.to.be.an.instanceof Buffer

			expect Array::slice.call buffer
			.to.eql [0b10100101, 0b00001111]

		it 'ignores any whitespace characters', ->
			buffer = binary.decode '11001010 01100110 10010010'

			expect buffer
			.to.be.an.instanceof Buffer

			expect Array::slice.call buffer
			.to.eql [0b11001010, 0b01100110, 0b10010010]

			buffer = binary.decode ' 001 01\t01 011   10 0\n 101 '

			expect buffer
			.to.be.an.instanceof Buffer

			expect Array::slice.call buffer
			.to.eql [0b00101010, 0b11100101]

		it 'pads with zero when octet is insufficient', ->
			buffer = binary.decode '0101110010011'

			expect buffer
			.to.be.an.instanceof Buffer

			expect Array::slice.call buffer
			.to.eql [0b01011100, 0b10011000]

		it 'throws error when invalid character is supplied', ->
			expect -> buffer.decode '010110a0'
			.to.throw Error

			expect -> buffer.decode 'l0ll0ll0'
			.to.throw Error
