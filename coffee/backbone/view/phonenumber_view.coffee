planbox.View.PhoneNumber = Backbone.View.extend {
	template: '',
	fn: '',
	errorbox:'',
	contactid: '',
	initialize: ->
		ctx = @;
		@collection.on "all", @render, @
		load = $.get '/template/number.jade.js'
		load.fail (req,settings,exception)->
			if req.status == 200
				ctx.template = req.responseText
				ctx.fn = jade.compile ctx.template
				
	,
	events:{
		"click .add" : "add",
		"click .delete" : "remove",
		"click .edit-btn" : "edit",
		"click .cancel": "cancel",
		"click .save": "save"
		
	},
	render: ->
		@$el.html @fn {numbers:@collection.toJSON()}
		@errorbox = @$el.find("#error")
		@errorbox.remove()
	,
	add: (e) ->
		name = @$el.find "#addphone #inputName"
		number = @$el.find "#addphone #inputNumber"
		ph = @collection.create {name:name.val(),number:number.val()}, {wait: true}
		if ph
			name.select 0
			number.val ""
			@collection.fetch()
			planbox.socket.emit "actionphone", { id:@options.contactid }
		else
			@$el.find("#addphone").prepend(@errorbox).show()
		
	,
	remove: (e) ->
		e.preventDefault()
		id = $(e.currentTarget).data "id"
		item = @collection.get id
		item.destroy {wait: true}
		@collection.fetch()
		planbox.socket.emit "actionphone", { id:@options.contactid }
	,
	edit: (e) ->
		e.preventDefault()
		id = $(e.currentTarget).data "id"
		div = @$el.find("div[data-id="+id+"]")
		div.find(".show").hide()
		div.find(".edit").show()
	,
	cancel: (e) ->
		e.preventDefault()
		id = $(e.currentTarget).data "id"
		div = @$el.find("div[data-id="+id+"]")
		div.find(".edit").hide()
		div.find(".show").show()
	,
	save : (e) ->
		e.preventDefault()
		id = $(e.currentTarget).data "id"
		div = @$el.find("div[data-id="+id+"]")
		item = @collection.get id
		number = $ "#inputNumber"
		if item.save {number:number.val()}
			div.find(".edit").hide()
			div.find(".show").show()
			number.val ""
			planbox.socket.emit "actionphone", { id:@options.contactid }
		else
			div.prepend @errorbox
			console.log @errorbox
		
}