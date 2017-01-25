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

# Populate the API directory from our managed copy.
# /var/www/node e.g.
# process jinja if there is any.
# Clean (delete) unexpected files
node-scripts:
  file.recurse:
    - name: {{ pillar['NODE_ROOT'] }}
    - source: salt://node
    - template: jinja
    - user: root
    - group: root
    - file_mode: 644
    - dir_mode: 755
    - clean: True

# Make sure that our hello world server is up
node-server-start:
  cmd.run:
    - name: pm2 start {{ pillar['NODE_ROOT'] }}/hello.js
