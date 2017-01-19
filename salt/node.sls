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

# Use our jinja-managed Hello World script
node-scripts:
  file.managed:
    - name: /var/www/html/hello.js
    - source: salt://node/hello.js.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 640

# Make sure that our hello world server is up
node-server-start:
  cmd.run:
    - name: pm2 start /var/www/html/hello.js
