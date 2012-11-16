planbox.Model.PhoneNumber = Backbone.Model.extend {
	validate: (attrs) ->
		if !attrs.name || !attrs.number
			return "name and number are mandatory"
		if attrs.name == "" || attrs.name == ""
			return "name and number must not be null"
}