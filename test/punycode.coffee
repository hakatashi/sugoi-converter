chai = require 'chai'
punycode = require '../src/punycode'

{equalityWith} = require './util'

expect = chai.expect

describe 'punycode', ->
	describe 'punycode.encode', ->
		it 'basically works', ->
			expect punycode.encode new Buffer 'punycode', 'ascii'
			.to.be.a 'string'
			.and.equal 'punycode-'

			# https://en.wikipedia.org/wiki/Punycode#Encoding_procedure
			expect punycode.encode new Buffer 'bücher', 'utf-8'
			.to.be.a 'string'
			.and.equal 'bcher-kva'

			expect punycode.encode new Buffer 'büücher', 'utf-8'
			.to.be.a 'string'
			.and.equal 'bcher-kvaa'

			expect punycode.encode new Buffer 'übücher', 'utf-8'
			.to.be.a 'string'
			.and.equal 'bcher-jvab'

			# https://ja.wikipedia.org/wiki/Punycode#.E6.A6.82.E8.A6.81
			expect punycode.encode new Buffer 'ドメイン名例', 'utf-8'
			.to.be.a 'string'
			.and.equal 'eckwd4c7cu47r2wf'

	describe 'punycode.decode', ->
		it 'basically works', ->
			expect punycode.decode 'punycode-'
			.to.satisfy equalityWith 'punycode'

			expect punycode.decode 'bcher-kva'
			.to.satisfy equalityWith 'bücher'

			expect punycode.decode 'bcher-kvaa'
			.to.satisfy equalityWith 'büücher'

			expect punycode.decode 'bcher-jvab'
			.to.satisfy equalityWith 'übücher'

			expect punycode.decode 'eckwd4c7cu47r2wf'
			.to.satisfy equalityWith 'ドメイン名例'

		it 'is case-insensitive for insertion operators', ->
			expect punycode.decode 'bcher-KvA'
			.to.satisfy equalityWith 'bücher'

		it 'throws error if invalid punycode is passed', ->
			# Invalid character
			expect -> punycode.decode '$'
			.to.throw Error

			# Invalid number specification
			expect -> punycode.decode 'bcher-kv'
			.to.throw Error
