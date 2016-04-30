chai = require 'chai'
md5 = require '../src/md5'

{equalityWith} = require './util'

expect = chai.expect

describe 'md5', ->
	describe 'md5.encode', ->
		# https://en.wikipedia.org/wiki/MD5#MD5_hashes
		it 'basically works', ->
			expect md5.encode new Buffer 'The quick brown fox jumps over the lazy dog', 'ascii'
			.to.be.a 'string'
			.and.equal '9e107d9d372bb6826bd81d3542a419d6'

			expect md5.encode new Buffer 'The quick brown fox jumps over the lazy dog.', 'ascii'
			.to.be.a 'string'
			.and.equal 'e4d909c290d0fb1ca068ffaddf22cbd0'

			expect md5.encode new Buffer '', 'ascii'
			.to.be.a 'string'
			.and.equal 'd41d8cd98f00b204e9800998ecf8427e'

	describe 'md5.decode', ->
		it 'throws error when attempt to decode', ->
			expect -> md5.decode 'd41d8cd98f00b204e9800998ecf8427e'
			.to.throw Error
