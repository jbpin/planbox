planbox.View.Contact = Backbone.View.extend {
	template: '',
	fn: '',
	errorbox: '',
	phoneCols: [],
	initialize: ->
		@errorbox = $ "#error"
		@errorbox.remove()
		ctx = @;
		@collection.on "all", @render, @
		load = $.get '/template/contact.jade.js'
		load.fail (req,settings,exception)->
			if req.status == 200
				ctx.template = req.responseText
				ctx.fn = jade.compile ctx.template
				
	,
	events: {
	    "click a.contact" : "open",
		"click #add #save" : "save",
		"click .delete-contact" : "remove"
	},
	getPhoneCol : (id) -> 
		@phoneCols[id]
	,	
	render: ->
		@$el.find("#contacts").html @fn {contacts:@collection.toJSON()}
	,
	open: (e) ->
		e.preventDefault()
		id = $(e.currentTarget).data "id"
		item = @collection.get id
		name = item.get "firstname"
		el = $("#phone"+item.get 'id')
		if el.hasClass 'in'
			el.collapse 'hide'
		else
			if !@phoneCols[item.get 'id']
				ph = item.getPhoneNumbers()
				new planbox.View.PhoneNumber {el:el, collection:ph,contactid:id}
				@phoneCols[item.get 'id'] = ph
			else
				ph = @phoneCols[item.get 'id']
				@collection.fetch()
			ph.fetch().success ->
				el.collapse('toggle')
				console.log ph
	,
	save: (e) ->
		fname = $ "#inputFirstname"
		lname = $ "#inputLastname"
		contact = @collection.create {firstname:lname.val(),lastname:fname.val()} , {wait: true}
		if contact
			fname.val ""
			lname.val ""
			@errorbox.remove()
			$("#add").collapse 'hide'
			@collection.fetch()
			planbox.socket.emit "actioncontact", { msg:"new contact" }
		else
			$("#add").prepend @errorbox
	remove: (e) ->
		e.preventDefault()
		id = $(e.currentTarget).data "id"
		item = @collection.get id
		item.destroy {wait: true, success: -> 
			planbox.socket.emit "actioncontact", { msg:"remove contact" }
		}
		
}


