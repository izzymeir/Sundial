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

# Populate the html directory from our managed copy.
# /var/www/html e.g.
node-populate-html-directory:
  file.recurse:
    - name: {{ pillar['NGINX_HTML_ROOT'] }}
    - source: salt://html
    - user: root
    - group: root
    - file_mode: 644
    - dir_mode: 644

# Populate the API directory with jinja-managed scripts
# /var/www/html/api e.g.
node-scripts:
  file.recurse:
    - name: {{ pillar['NGINX_HTML_ROOT'] }}/{{ pillar['NODE_VIRTUAL_DIRECTORY'] }}
    - source: salt://node
    - template: jinja
    - user: root
    - group: root
    - file_mode: 644
    - dir_mode: 644

# Make sure that our hello world server is up
node-server-start:
  cmd.run:
    - name: pm2 start /var/www/html/hello.js
