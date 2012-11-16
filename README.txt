Install : 
Download and install node.js
	http://nodejs.org/download/
Install Express (root)
	npm -g install express
Install coffee-script (root)
	npm -g install coffee-script
Install js2coffee (root)
	npm -g install js2coffee
Initialize project
	express planbox && cd planbox
	npm install
Translate js to coffee
	js2coffee app.js > app.coffee
	