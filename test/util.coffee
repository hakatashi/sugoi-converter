chai = require 'chai'

expect = chai.expect

###*
 * Return function that test equality with given buffer to byteArray.
 * Use like expect(new Buffer([42, 42])).to.satisfy(equalityWith([42, 42]))
 * @param  {number[]} byteArray
 * @return {function}
###
exports.equalityWith = (byteArray) ->
	(buffer) ->
		expect buffer
		.to.be.an.instanceof Buffer

		expect Array::slice.call buffer
		.to.be.eql byteArray

		return true
