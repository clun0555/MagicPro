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


describe "addOne Exemplary Tests2", ->
	
	Controller = undefined
	
	###
	Instead of requiring add-one in each test--making each test async,
	require it in beforeEach, clone it, and sneak it into a global
	so that no test can (permanently) mess with / mutate it.
	###
	beforeEach (done) ->
		require ["base/utils/Controller"], (_Controller) ->
			Controller = clone(_Controller)
			done()

	it "Should exist.", ->
		expect(Controller).to.exist

	it "Should call action", ->
		class TestController extends Controller

			callMe: ->
				

		expect(Controller).to.exist		

	
