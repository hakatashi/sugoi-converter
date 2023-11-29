chai = require 'chai'
base58 = require '../src/base58'

{equalityWith} = require './util'

expect = chai.expect

describe 'base58', ->
	describe 'base58.encode', ->
		it 'basically works', ->
			expect base58.encode Buffer.from 'Hello World!', 'ascii'
			.to.be.a 'string'
			.and.equal '2NEpo7TZRRrLZSi2U'

	describe 'base58.decode', ->
		it 'basically works', ->
			expect base58.decode Buffer.from '2NEpo7TZRRrLZSi2U', 'ascii'
			.to.satisfy equalityWith 'Hello World!'