// Simple Hello World! test

// get an http object
var http = require('http');

// create a server with simple response, and make it listen for requests
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Hello World\n');
}).listen(8080, '13.92.32.38');

// tell us we're good to go
console.log('Server running at http://13.92.32.38:8080/');
