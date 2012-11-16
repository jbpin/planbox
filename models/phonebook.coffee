Sequelize = require("sequelize")
db = "planbox"
user = "root"
pass = "root"
host = "127.0.0.1"
port = "8889"

sequelize = new Sequelize db, user, pass, {host:host , port:port}
contact = sequelize.define 'Contact', {firstname:Sequelize.STRING,lastname:Sequelize.STRING}
phonenumber = sequelize.define 'PhoneNumber', {name:{type:Sequelize.STRING, notEmpty: true}, number:{type:Sequelize.STRING, notEmpty: true}}
contact.hasMany phonenumber, {as:'Numbers'}
phonenumber.belongsTo contact, {as:'Contact'}
module.exports = {
	Contact : contact
	PhoneNumber : phonenumber
	addContact : (lastname,firstname) ->
		c = new Contact firstname, lastname
		c.save()
	deleteContact : (id) ->
		Contact.find(id).success (contact) ->
			contact.destroy().success ->
				true
			
}
sequelize.sync()


