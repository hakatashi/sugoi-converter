{expect} = require 'chai'
quotedprintable = require '../src/quotedprintable'

{equalityWith} = require './util'

# https://en.wikipedia.org/wiki/Ascii85#Example_for_Ascii85

EXAMPLE_PLAIN = 'コナン=新一'

EXAMPLE_QUOTEDPRINTABLE = '=E3=82=B3=E3=83=8A=E3=83=B3=3D=E6=96=B0=E4=B8=80'

describe 'quotedprintable', ->
	describe 'quotedprintable.encode', ->
		it 'basically works', ->
			expect quotedprintable.encode Buffer.from EXAMPLE_PLAIN
			.to.be.a 'string'
			.and.equal EXAMPLE_QUOTEDPRINTABLE

	describe 'quotedprintable.decode', ->
		it 'basically works', ->
			expect quotedprintable.decode EXAMPLE_QUOTEDPRINTABLE
			.to.satisfy equalityWith EXAMPLE_PLAIN
