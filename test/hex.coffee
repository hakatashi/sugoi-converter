chai = require 'chai'
hex = require '../src/hex'

{equalityWith} = require './util'

expect = chai.expect

describe 'hex', ->
	describe 'hex.encode', ->
		it 'basically works', ->
			expect hex.encode new Buffer [0xDE, 0xAD, 0xBE, 0xEF]
			.to.be.a 'string'
			.and.equal 'DEADBEEF'

	describe 'hex.decode', ->
		it 'basically works', ->
			expect hex.decode 'DEADBEEF'
			.to.satisfy equalityWith [0xDE, 0xAD, 0xBE, 0xEF]

		it 'ignores cases', ->
			expect hex.decode 'dEaDBEef'
			.to.satisfy equalityWith [0xDE, 0xAD, 0xBE, 0xEF]

		it 'ignores any whitespace characters', ->
			expect hex.decode 'DEAD beef'
			.to.satisfy equalityWith [0xDE, 0xAD, 0xBE, 0xEF]

			expect hex.decode ' D\t\tEa   dbe \neF   '
			.to.satisfy equalityWith [0xDE, 0xAD, 0xBE, 0xEF]

		it 'throws error when length of hex is not byte-aligned', ->
			expect -> hex.decode 'DEAD BEE'
			.to.throw Error

		it 'throws error when invalid character is supplied', ->
			expect -> hex.decode 'DEAD NIKU'
			.to.throw Error

			expect -> hex.decode 'ア'
			.to.throw Error
