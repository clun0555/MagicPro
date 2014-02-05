define [
	"common/utils/utils"
], (utils) ->
	
	describe "just checking", ->
		
		it "works for app", ->
			
			expect(utils.getQueryParams("?hello=world")).toEqual { "hello" : "world"}
			
			return		

		return

	return
