planbox.Collection.PhoneNumber = Backbone.Collection.extend {
	initialize: (models,options) ->
		this.contactid = options.contactid
	model: planbox.Model.PhoneNumber,
	url : ->
		"/contact/"+@contactid+"/phonenumber"
}