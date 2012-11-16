each number , i in numbers
	div(data-id=number.id)
		div.show
			p
				strong #{number.name}
				| #{number.number}
				button.btn.btn-mini.pull-right.edit-btn(data-id=number.id) 
					i.icon-pencil
		div.edit(style="display:none")
			p
				strong #{number.name}
				input#inputNumber(type="text", value="#{number.number}")
	
				button.btn.btn-danger.btn-mini.pull-right.delete(data-id=number.id) 
					|supprimer
				button.btn.btn-success.btn-mini.pull-right.save(data-id=number.id) 
					|enregistrer
				button.btn.btn-mini.pull-right.cancel(data-id=number.id) 
					|annuler
div#error.alert.alert-error
	button.close(data-dismiss="alert") x
	strong Error
	|  Vous devez précisez un numéro de téléphone
form.form-inline#addphone
	select#inputName
		option Home
		option Work
		option Cellular
		option Other
	input(type="text",id="inputNumber")
	div.add.btn.btn-success Ajouter