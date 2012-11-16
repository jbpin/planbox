phoneBook = require '../models/phonebook'

exports.list = (req,res) ->
	phoneBook.Contact.all().success (contacts) ->
		res.json contacts

exports.add = (req,res) ->
	fname = req.body.firstname
	lname = req.body.lastname
	if !lname || !fname
		res.writeHead 401
		res.send()
		return
	c = phoneBook.Contact.create({firstname:fname, lastname:lname}).success (contact) ->
		res.writeHead 201, {'location': req.url+"/"+contact.id}
		res.send()
		
exports.get = (req,res) ->
	phoneBook.Contact.find(parseInt req.params.id).success (contact) ->
		res.json contact
		
exports.put = (req,res) ->
	fname = req.body.firstname
	lname = req.body.lastname
	if !lname || !fname
		res.writeHead 401
		res.send()
		return
	phoneBook.Contact.find(parseInt req.params.id).success (contact) ->
		contact.firstname = fname
		contact.lastname = lname
		contact.save().success ->
			res.json contact
	
exports.delete = (req,res) ->
	phoneBook.Contact.find(parseInt req.params.id).success (contact) ->
		contact.destroy().success ->
			res.send()