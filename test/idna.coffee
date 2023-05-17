chai = require 'chai'
idna = require '../src/idna'

{equalityWith} = require './util'

expect = chai.expect

describe 'idna', ->
	describe 'idna.encode', ->
		it 'basically works', ->
			expect idna.encode Buffer.from 'idna', 'ascii'
			.to.be.a 'string'
			.and.equal 'idna'

			# https://en.wikipedia.org/wiki/idna#Encoding_procedure
			expect idna.encode Buffer.from 'bücher', 'utf-8'
			.to.be.a 'string'
			.and.equal 'xn--bcher-kva'

			expect idna.encode Buffer.from 'büücher', 'utf-8'
			.to.be.a 'string'
			.and.equal 'xn--bcher-kvaa'

			expect idna.encode Buffer.from 'übücher', 'utf-8'
			.to.be.a 'string'
			.and.equal 'xn--bcher-jvab'

			# https://ja.wikipedia.org/wiki/idna#.E6.A6.82.E8.A6.81
			expect idna.encode Buffer.from 'ドメイン名例', 'utf-8'
			.to.be.a 'string'
			.and.equal 'xn--eckwd4c7cu47r2wf'

		it 'normalize characters with NFKC', ->
			expect idna.encode Buffer.from 'Ⓤ⒯ⓢ④⁶', 'utf-8'
			.to.be.a 'string'
			.and.equal 'u(t)s46'

		it 'does not convert characters with transitional processing', ->
			# http://unicode.org/reports/tr46/#Deviations
			expect idna.encode Buffer.from 'faß', 'utf-8'
			.to.be.a 'string'
			.and.equal 'xn--fa-hia'

			expect idna.encode Buffer.from 'βόλος', 'utf-8'
			.to.be.a 'string'
			.and.equal 'xn--nxasmm1c'

			expect idna.encode Buffer.from 'ශ්‍රී', 'utf-8'
			.to.be.a 'string'
			.and.equal 'xn--10cl1a0b660p'

			expect idna.encode Buffer.from 'نامه‌ای', 'utf-8'
			.to.be.a 'string'
			.and.equal 'xn--mgba3gch31f060k'

	describe 'idna.decode', ->
		it 'basically works', ->
			expect idna.decode 'idna'
			.to.satisfy equalityWith 'idna'

			expect idna.decode 'xn--bcher-kva'
			.to.satisfy equalityWith 'bücher'

			expect idna.decode 'xn--bcher-kvaa'
			.to.satisfy equalityWith 'büücher'

			expect idna.decode 'xn--bcher-jvab'
			.to.satisfy equalityWith 'übücher'

			expect idna.decode 'xn--eckwd4c7cu47r2wf'
			.to.satisfy equalityWith 'ドメイン名例'

		it 'is case-insensitive for insertion operators', ->
			expect idna.decode 'xn--bcher-KvA'
			.to.satisfy equalityWith 'bücher'

		it 'throws error if invalid idna is passed', ->
			# Invalid character
			expect -> idna.decode 'xn--$'
			.to.throw Error

			# Invalid number specification
			expect -> idna.decode 'xn--bcher-kv'
			.to.throw Error

