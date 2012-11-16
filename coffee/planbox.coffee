planbox = {
	Model : {},
	Collection : {},
	View : {},
	contacts : {},
	contact_view: {},
	socket : {},
	init: ->
		@contacts = new @Collection.Contact()
		@contact_view = new @View.Contact({collection:@contacts,el:$ "#list"})
		@contacts.fetch()
}

$(document).ready ->
	#col = new planbox.Collection.Contact()
	planbox.init()
	socket = io.connect window.location
	socket.on 'connected', (data) ->
		console.log data
	socket.on 'reloadphone', (data) ->
		console.log "data reload"
		ph = planbox.contact_view.getPhoneCol data.contact_id
		if ph
			ph.fetch()
	socket.on 'reloadcontact', (data) ->
		ph = planbox.contacts.fetch()
	planbox.socket = socket