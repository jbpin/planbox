phoneBook = require '../models/phonebook'

exports.list = (req,res) ->
	phoneBook.Contact.find(parseInt req.params.id).success (contact) ->
		console.log contact
		contact.getNumbers().success (phonenumber) ->
			res.json phonenumber
			
exports.get = (req,res) ->
	phoneBook.Contact.find(parseInt req.params.id).success (contact) ->
		phoneBook.PhoneNumber.find(parseInt req.params.phoneid).success (phonenumber) ->
			contact.hasNumbers([phonenumber]).success (result) ->
				if result
					res.json phonenumber
				else
					res.setHeader(404)
					res.send()
					
exports.add = (req,res) ->
	id = req.params.id
	name = req.body.name
	number = req.body.number
	if !name || !number
		res.writeHead 401
		res.send()
		return
	phoneBook.Contact.find(parseInt req.params.id).success (contact) ->
		phoneBook.PhoneNumber.create({name:name,number:number}).success (ph) ->
			ph.setContact(contact).success ->
				ph.save().success ->
					res.writeHead 201, {'location': req.url+"/"+ph.id}
					res.send()
				
exports.update = (req, res) ->
	number = req.body.number
	phoneBook.PhoneNumber.find(parseInt req.params.phoneid).success (phone) ->
		if phone
			phone.number = number
			phone.save().success (result) ->
				res.send()
				
exports.delete = (req,res) ->
	phoneBook.PhoneNumber.find(parseInt req.params.phoneid).success (phone) ->
		if phone
			phone.destroy().success (result) ->
				res.send()