chai = require 'chai'
ascii85 = require '../src/ascii85'

{equalityWith} = require './util'

expect = chai.expect

# https://en.wikipedia.org/wiki/Ascii85#Example_for_Ascii85

EXAMPLE_PLAIN = '
	Man is distinguished, not only by his reason, but by this singular passion from
	other animals, which is a lust of the mind, that by a perseverance of delight
	in the continued and indefatigable generation of knowledge, exceeds the short
	vehemence of any carnal pleasure.
'

EXAMPLE_ASCII85 = '''
	<~9jqo^BlbD-BleB1DJ+*+F(f,q/0JhKF<GL>Cj@.4Gp$d7F!,L7@<6@)/0JDEF<G%<+EV:2F!,
	O<DJ+*.@<*K0@<6L(Df-\\0Ec5e;DffZ(EZee.Bl.9pF"AGXBPCsi+DGm>@3BB/F*&OCAfu2/AKY
	i(DIb:@FD,*)+C]U=@3BN#EcYf8ATD3s@q?d$AftVqCh[NqF<G:8+EV:.+Cf>-FD5W8ARlolDIa
	l(DId<j@<?3r@:F%a+D58'ATD4$Bl@l3De:,-DJs`8ARoFb/0JMK@qB4^F!,R<AKZ&-DfTqBG%G
	>uD.RTpAKYo'+CT/5+Cei#DII?(E,9)oF*2M7/c~>
'''

describe 'ascii85', ->
	describe 'ascii85.encode', ->
		it 'basically works', ->
			expect ascii85.encode Buffer.from EXAMPLE_PLAIN, 'ascii'
			.to.be.a 'string'
			.and.equal EXAMPLE_ASCII85.replace /\n/g, ''

		it 'supports zero compression', ->
			# https://en.wikipedia.org/wiki/Ascii85#Basic_idea
			expect ascii85.encode Buffer.from [0, 0, 0, 0]
			.to.be.a 'string'
			.and.equal '<~z~>'

	describe 'ascii85.decode', ->
		it 'basically works', ->
			expect ascii85.decode EXAMPLE_ASCII85
			.to.satisfy equalityWith EXAMPLE_PLAIN

		it 'supports zero compression', ->
			expect ascii85.decode '<~z~>'
			.to.satisfy equalityWith [0, 0, 0, 0]
