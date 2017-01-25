
{%- set address = pillar['NODE_SERVER_IP'] -%}
{%- set port = pillar['NODE_SERVER_PORT'] -%}

// Simple Hello World! test - now with invisible jinja!

// get an http object
var http = require('http');

// create a server with simple response, and make it listen for requests
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Hello World! Love, nodejs\n');
}).listen({{ port }}, '{{ address }}');

// tell us we're good to go
console.log('Server running at http://{{ address }}:{{ port }}/');
