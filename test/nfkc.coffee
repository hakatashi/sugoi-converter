chai = require 'chai'
nfkc = require '../src/nfkc'

expect = chai.expect

describe 'nfkc', ->
	describe 'nfkc.encode', ->
		it 'basically works nfkc normalization', ->
			expect nfkc.encode Buffer.from 'café'
			.to.be.a 'string'
			.and.equal 'café'

			expect nfkc.encode Buffer.from 'Ⅲ'
			.to.be.a 'string'
			.and.equal 'III'

	describe 'nfkc.decode', ->
		it 'throws error when attempt to decode', ->
			expect -> nfkc.decode 'café'
			.to.throw Error
