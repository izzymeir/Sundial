# We want nginx and mongodb to be here first
include:
  - nginx
  - mongodb

# make sure node and its package manager is installed
node-install:
  pkg.installed:
    - pkgs:
      - nodejs
      - nodejs-legacy
      - npm

# make sure we have pm2
node-pm2-installed:
  cmd.run:
    - name: sudo npm install pm2 -g

# put our Hello World script in the right place
node-scripts:
  file.managed:
    - name: /var/www/html/hello.js
    - source: salt://node/hello.js

# Make sure that our hello world server is up
node-server-start:
  cmd.run:
    - name: pm2 start /var/www/html/hello.js
