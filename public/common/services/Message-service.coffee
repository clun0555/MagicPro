define [
	"./services"
	"underscore"
	"common/utils/utils"
], (services, _, utils) ->	

	services.service "MessageService", ($resource, $q) ->

		Messages = $resource "/api/messages/:id", { "_id": "@id"}, { 'update': {method:'PUT'} }

		
		send: (message) ->
			Messages.save( { }, message).$promise

		




		
