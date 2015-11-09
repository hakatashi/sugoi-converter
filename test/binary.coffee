chai = require 'chai'
binary = require '../src/binary'

expect = chai.expect

describe 'binary', ->
	describe 'binary.encode', ->
		it 'basically works', ->
			text = binary.encode new Buffer [0b11001010, 0b00110101]
			expect(text).to.be.a 'string'
			expect(text).to.equal '1100101000110101'

	describe 'binary.decode', ->
		it 'basically works', ->
			buffer = binary.decode '1010010100001111'
			expect(buffer).to.be.an.instanceof Buffer
			expect(Array::slice.call buffer).to.eql [0b10100101, 0b00001111]
