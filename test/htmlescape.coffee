chai = require 'chai'
htmlescape = require '../src/htmlescape'

{equalityWith} = require './util'

expect = chai.expect

describe 'htmlescape', ->
	describe 'htmlescape.encode', ->
		it 'basically works', ->
			expect htmlescape.encode new Buffer '<script>©2016 博多市</script>'
			.to.be.a 'string'
			.and.equal '&lt;script&gt;&copy;2016&nbsp;&#21338;&#22810;&#24066;&lt;/script&gt;'

	describe 'htmlescape.decode', ->
		it 'basically works', ->
			expect htmlescape.decode '&lt;script&gt;&copy;2016&nbsp;&#21338;&#22810;&#24066;&lt;/script&gt;'
			.to.satisfy equalityWith '<script>©2016 博多市</script>'

		it 'fairly decodes unlisted entity sequenses as raw text', ->
			expect htmlescape.decode '&hoge;'
			.to.satisfy equalityWith '&hoge;'
