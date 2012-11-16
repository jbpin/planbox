planbox.Model.Contact = Backbone.Model.extend {
	urlRoot: "/contact",
	validate : (attrs) ->
		if !attrs.firstname || !attrs.lastname
			return "You must provide a firstname and a lastname"
		if attrs.firstname == "" || attrs.lastname == ""
			return "You must provide a firstname and a lastname"
	,
	getPhoneNumbers : ->
		ph = new planbox.Collection.PhoneNumber [], {contactid:@get "id"}
		ph
}