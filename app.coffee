
express = require 'express'
form = require "connect-form"
app = module.exports = express.createServer();


app.configure () ->
  app.use form()
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express.static(__dirname + '/public'));

app.configure 'development', () ->
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true })); 

app.configure 'production', () ->
  app.use(express.errorHandler()); 

# Routes

app.get '/', (req, res) ->
  res.sendfile "index.html"
  #res.send "hello world"

app.post '/', (req, res) ->
#res.send req.method + "   " + req.headers['content-type']
  if not req.form then return res.send "no form"
  req.form.complete (err, fields, files) ->
    res.send JSON.stringify files


exports.app = app

if (!module.parent) 
  app.listen(8001);
  console.log("Express server listening on port %d", app.address().port);

