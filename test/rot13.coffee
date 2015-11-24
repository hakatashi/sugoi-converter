chai = require 'chai'
rot13 = require '../src/rot13'

{equalityWith} = require './util'

expect = chai.expect

# https://en.wikipedia.org/wiki/ROT13

WIKIPEDIA_PLAIN = """
	Why did the chicken cross the road?
	Gb trg gb gur bgure fvqr!
"""
WIKIPEDIA_ENCODED = """
	Jul qvq gur puvpxra pebff gur ebnq?
	To get to the other side!
"""

describe 'rot13', ->
	describe 'rot13.encode', ->
		it 'basically works', ->
			expect rot13.encode new Buffer WIKIPEDIA_PLAIN
			.to.be.a 'string'
			.and.equal WIKIPEDIA_ENCODED

		it 'keeps characters which isnt alphabet untouched', ->
			expect rot13.encode new Buffer '!"#$%&(=~|abc'
			.to.be.a 'string'
			.and.equal '!"#$%&(=~|nop'

	describe 'rot13.decode', ->
		it 'basically works', ->
			expect rot13.decode WIKIPEDIA_ENCODED
			.to.satisfy equalityWith WIKIPEDIA_PLAIN

		it 'keeps characters which isnt alphabet untouched', ->
			expect rot13.decode '!"#$%&(=~|nop'
			.to.satisfy equalityWith '!"#$%&(=~|abc'
