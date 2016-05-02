chai = require 'chai'
nfc = require '../src/nfc'

expect = chai.expect

describe 'nfc', ->
	describe 'nfc.encode', ->
		it 'basically works NFC normalization', ->
			expect nfc.encode Buffer.from 'café'
			.to.be.a 'string'
			.and.equal 'café'

		it 'doesn\'t do NFKC normalization', ->
			expect nfc.encode Buffer.from 'Ⅲ'
			.to.be.a 'string'
			.and.equal 'Ⅲ'

	describe 'nfc.decode', ->
		it 'throws error when attempt to decode', ->
			expect -> nfc.decode 'café'
			.to.throw Error
