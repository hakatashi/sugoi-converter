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
			expect buffer.toString 'hex'
			.to.be.equal data.toString 'hex'
		else if typeof data is 'string'
			expect buffer.toString 'hex'
			.to.be.equal new Buffer(data).toString 'hex'
		else
			return false

		return true
