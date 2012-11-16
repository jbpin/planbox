Download and install node.js
	http://nodejs.org/download/

Install coffee-script (root)
	npm -g install coffee-script

Checkout project
	git clone git://github.com/jbpin/planbox.git

Initialize project
	npm install

Put db details in ./models/phonebook.coffee

Compile coffee to js (not necessary)
	cd coffee
	coffee -c -j ../public/js/planbox.js planbox.coffee backbone/model/* backbone/collection/* backbone/view/*

Running the projet
	coffee app.coffee

Access to the application
	http://localhost:3000


