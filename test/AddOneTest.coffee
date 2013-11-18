###
Clones / deep copies an object.

@param Object obj
Any object.

@return Object
obj--cloned.
###
clone = (obj) ->
	return obj  if obj is null or typeof (obj) isnt "object"
	temp = new Object()
	for key of obj
		temp[key] = clone(obj[key])
	temp

expect = chai.expect



describe "addOne Exemplary Tests", ->
	
	AddOne = undefined
	
	###
	Instead of requiring add-one in each test--making each test async,
	require it in beforeEach, clone it, and sneak it into a global
	so that no test can (permanently) mess with / mutate it.
	###
	beforeEach (done) ->
		require ["AddOne"], (_AddOne) ->
			AddOne = clone(_AddOne)
			done()

	it "Should be 2.", ->
		expect(AddOne.addOne(1)).to.equal 2
		# chai.assert.equal AddOne.addOne(1), 2

	it "Should be 42; Sinon stub.", ->
		
		# Stub addOne to return 42--no matter what.
		AddOne.addOne = sinon.stub().returns(42)
		chai.assert.equal AddOne.addOne(1), 42

	it "Should be 2 (again); unstubbed.", ->
		chai.assert.equal AddOne.addOne(1), 2

