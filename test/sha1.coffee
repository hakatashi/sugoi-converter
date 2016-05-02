chai = require 'chai'
sha1 = require '../src/sha1'

{equalityWith} = require './util'

expect = chai.expect

describe 'sha1', ->
	describe 'sha1.encode', ->
		# https://en.wikipedia.org/wiki/SHA-1#Example_hashes
		it 'basically works', ->
			expect sha1.encode Buffer.from 'The quick brown fox jumps over the lazy dog', 'ascii'
			.to.be.a 'string'
			.and.equal '2fd4e1c67a2d28fced849ee1bb76e7391b93eb12'

			expect sha1.encode Buffer.from 'The quick brown fox jumps over the lazy cog', 'ascii'
			.to.be.a 'string'
			.and.equal 'de9f2c7fd25e1b3afad3e85a0bd17d9b100db4b3'

			expect sha1.encode Buffer.from '', 'ascii'
			.to.be.a 'string'
			.and.equal 'da39a3ee5e6b4b0d3255bfef95601890afd80709'

	describe 'sha1.decode', ->
		it 'throws error when attempt to decode', ->
			expect -> sha1.decode '2fd4e1c67a2d28fced849ee1bb76e7391b93eb12'
			.to.throw Error
