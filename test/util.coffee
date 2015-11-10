chai = require 'chai'

expect = chai.expect

###*
 * Return function that test equality with given buffer to byteArray.
 * Use like expect(new Buffer([42, 42])).to.satisfy(equalityWith([42, 42]))
 * @param  {number[]} byteArray
 * @return {function}
###
exports.equalityWith = (data) ->
	(buffer) ->
		expect buffer
		.to.be.an.instanceof Buffer

		if Array.isArray data
			expect Array::slice.call buffer
			.to.be.eql data
		else if data instanceof Buffer
			expect buffer.compare data
			.to.be.equal 0
		else if typeof data is 'string'
			expect buffer.compare new Buffer data
			.to.be.equal 0
		else
			return false

		return true
