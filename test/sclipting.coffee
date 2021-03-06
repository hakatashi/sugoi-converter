chai = require 'chai'
sclipting = require '../src/sclipting'

{equalityWith} = require './util'

expect = chai.expect

describe 'sclipting', ->
	describe 'sclipting.encode', ->
		it 'basically works', ->
			# https://esolangs.org/wiki/Sclipting#Byte-array_literals
			expect sclipting.encode Buffer.from [0x00]
			.to.be.a 'string'
			.and.equal '가'

			expect sclipting.encode Buffer.from [0x2A, 0x2F]
			.to.be.a 'string'
			.and.equal '꺢및'

			expect sclipting.encode Buffer.from [0x2A, 0x2F, 0x00]
			.to.be.a 'string'
			.and.equal '꺢묀'

			expect sclipting.encode Buffer.from 'Sclipting', 'utf8'
			.to.be.a 'string'
			.and.equal '넶꽬늗건늖멧'

			expect sclipting.encode Buffer.from 'ДЖ', 'utf16le'
			.to.be.a 'string'
			.and.equal '굀뀖걀'

			# https://esolangs.org/wiki/Sclipting#Hello.2C_World.21
			expect sclipting.encode Buffer.from 'Hello, World!', 'ascii'
			.to.be.a 'string'
			.and.equal '낆녬닆묬긅덯댦롤긐'

	describe 'sclipting.decode', ->
		it 'basically works', ->
			expect sclipting.decode '가'
			.to.satisfy equalityWith [0x00]

			expect sclipting.decode '꺢및'
			.to.satisfy equalityWith [0x2A, 0x2F]

			expect sclipting.decode '꺢묀'
			.to.satisfy equalityWith [0x2A, 0x2F, 0x00]

			expect sclipting.decode '넶꽬늗건늖멧'
			.to.satisfy equalityWith Buffer.from 'Sclipting', 'utf8'

			expect sclipting.decode '굀뀖걀'
			.to.satisfy equalityWith Buffer.from 'ДЖ', 'utf16le'

			expect sclipting.decode '낆녬닆묬긅덯댦롤긐'
			.to.satisfy equalityWith Buffer.from 'Hello, World!', 'ascii'
