chai = require 'chai'
uuencode = require '../src/uuencode'

{equalityWith} = require './util'

expect = chai.expect

describe 'uuencode', ->
	describe 'uuencode.encode', ->
		it 'basically works', ->
			# https://en.wikipedia.org/wiki/Uuencoding#Formatting_mechanism
			expect uuencode.encode Buffer.from 'Cat', 'ascii'
			.to.equal '#0V%T\n'

	describe 'uuencode.decode', ->
		it 'basically works', ->
			# https://en.wikipedia.org/wiki/Uuencoding#Formatting_mechanism
			expect uuencode.decode '#0V%T\n'
			.to.satisfy equalityWith Buffer.from 'Cat', 'ascii'
