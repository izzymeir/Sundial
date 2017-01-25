# Make sure we have nginx
nginx-install:
  pkg.installed:
    - name: nginx

# We need to allow our server bind to an outside IP address that it doesn't know
# Use our copy of sysctl.conf
/etc/sysctl.conf:
  file.managed:
    - source: salt://nginx/sysctl.conf

# Load our sysctl.conf
sysctl-load-config-file:
  cmd.run:
    - name: sudo sysctl -p /etc/sysctl.conf

# Use our copy of nginx.conf
/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://nginx/nginx.conf
    - user: root
    - group: root
    - mode: 640

# Use our jinja-managed configuration file
/etc/nginx/sites-available/default:
  file.managed:
    - source: salt://nginx/sites-available/default.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 640

# Make sure that the default file is enabled by putting a symbolic link to it in the sites-enabled directory
/etc/nginx/sites-enabled/default:
  file.symlink:
    - target: /etc/nginx/sites-available/default
    - require:
      - file: /etc/nginx/sites-available/default

# Populate the html directory from our managed copy.
# /var/www/html e.g.
nginx-populate-html-directory:
  file.recurse:
    - name: {{ pillar['NGINX_HTML_ROOT'] }}
    - source: salt://html
    - user: root
    - group: root
    - mode: 644

# Make sure nginx service is running
nginx-start:
  service.running:
    - name: nginx
    - watch:
      - pkg: nginx
      - file: /etc/nginx/nginx.conf
      - file: /etc/nginx/sites-available/default
    - require:
      - pkg: nginx
