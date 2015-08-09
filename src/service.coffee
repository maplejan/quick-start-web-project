async = require 'async'
path = require 'path'
express = require 'express'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
partials = require 'express-partials'
routes = require './routes'

options =
  port: 9222
  host: '127.0.0.1'

# todo
configs =
  directory:
    views: 'develop/views'
    public: 'develop/public'


service = do express

# view engine setup
service.set 'views', path.join __dirname, configs.directory.views
service.set 'view engine', 'ejs'

service.use bodyParser.json {}
service.use bodyParser.urlencoded { extended: false }
service.use do cookieParser
service.use do partials
service.use express.static "#{__dirname}/#{configs.directory.public}"

routes service


service.listen options.port, () ->
  console.log "#{options.host} running at http://127.0.0.1:#{options.port}"
