ctrls = require './controllers'

module.exports = (server) ->
  server.get '/', [ctrls.home.index]