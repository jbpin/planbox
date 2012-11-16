
###
Module dependencies.
###
express = require "express"
routes = require "./routes"
contact = require "./routes/contact"
phonenumber = require "./routes/phonenumber"
http = require "http"
path = require "path"
model = require "./models/phonebook"
io = require 'socket.io'
io_utils = require './utils/io'
app = express()
app.configure ->
  app.set "port", process.env.PORT or 3000
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  app.use express.favicon()
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(path.join(__dirname, "public"))

app.configure "development", ->
  app.use express.errorHandler()

app.get "/", routes.index
app.get "/contact", contact.list
app.post "/contact", contact.add

app.get "/contact/:id", contact.get
app.put "/contact/:id", contact.put
app.delete "/contact/:id", contact.delete

app.get "/contact/:id/phonenumber", phonenumber.list
app.get "/contact/:id/phonenumber/:phoneid", phonenumber.get
app.delete "/contact/:id/phonenumber/:phoneid", phonenumber.delete
app.put "/contact/:id/phonenumber/:phoneid", phonenumber.update
app.post "/contact/:id/phonenumber", phonenumber.add


server = http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
iosocket = io.listen(server)
io_utils.io(iosocket)

iosocket.sockets.on 'connection',  (socket) ->
  socket.emit "connected", {msg:"welcome aboard"}
  socket.on "actionphone", (data)->
    console.log data.id
    socket.broadcast.emit "reloadphone", {contact_id:data.id}
  socket.on "actioncontact", (data)->
    socket.broadcast.emit "reloadcontact", {msg:"please reload contact"}
