chai = require 'chai'
urlescape = require '../src/urlescape'

{equalityWith} = require './util'

expect = chai.expect

TEST_FROM = 'LOVE & PEACE'
TEST_TO = 'LOVE%20%26%20PEACE'

describe 'urlescape', ->
	describe 'urlescape.encode', ->
		it 'basically works', ->
			expect urlescape.encode Buffer.from TEST_FROM
			.to.be.a 'string'
			.and.equal TEST_TO

	describe 'urlescape.decode', ->
		it 'basically works', ->
			expect urlescape.decode TEST_TO
			.to.satisfy equalityWith Buffer.from TEST_FROM
