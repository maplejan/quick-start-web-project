async = require 'async'
fs = require 'fs'
path = require 'path'


module.exports =
  index: (req, res, next) ->
    base =
      title: 'Home Page'
      keywords: ""
      description: ""
    res.render 'index',
      base: base
