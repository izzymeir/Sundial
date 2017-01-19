// Simple Hello World! test

// get an http object
var http = require('http');

// create a server with simple response, and make it listen for requests
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Hello World! Love, nodejs\n');
}).listen(8081, '127.0.0.1');

// tell us we're good to go
console.log('Server running at http://127.0.0.1:8081/');
