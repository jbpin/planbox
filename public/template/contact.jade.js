div#contact-list
	each ct, i in contacts
		div.contact-item 
			div
				a.delete-contact.pull-right(data-id="#{ct.id}",title="supprimer le contact") 
					i.icon-remove.icon
				a.contact(data-id="#{ct.id}") #{ct.firstname} #{ct.lastname}
			div.phone.collapse(id="phone#{ct.id}")
			
		