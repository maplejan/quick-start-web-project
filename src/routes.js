// Generated by CoffeeScript 1.9.2
(function() {
  var ctrls;

  ctrls = require('./controllers');

  module.exports = function(server) {
    return server.get('/', [ctrls.home.index]);
  };

}).call(this);
