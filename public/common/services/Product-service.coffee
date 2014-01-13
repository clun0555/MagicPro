define [
	"./services"	
], (services) ->	

	services.service "ProductService", ($rootScope, $fileUploader, UuidService) ->
		
		getNextDesignIdentifier: (product) ->
				
			counter = 0

			prefix = product.designs?[0]?.identifier?[0]
			prefix ?= "S" 

			for design in product.designs 
				if design.identifier?.length is 3
					num = parseInt(design.identifier.substring(1, 3), 10)
					counter = num if not _.isNaN(num) and num > counter

			counter += 1

			s = "000000000" + counter
			padCounter = s.substr(s.length - 2)

			prefix + padCounter
		
		



		

		
			





			







