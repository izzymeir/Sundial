# Settings for UFW - Uncomplicated FireWall

# Make sure we installed and configured nginx, mongodb, and nodejs
include:
  - nginx
  - mongodb
  - node

# Make sure SSH is there
ssh-installed:
  pkg.installed:
    - name: ssh
  service.running:
    - name: ssh
    - require:
      - pkg: ssh

# Make sure UFW is there
ufw-installed-and-running:
  pkg.installed:
    - name: ufw
  service.running:
    - name: ufw
    - require:
      - pkg: ufw

# Tell UFW reset to its initial configuration, so we know what we're starting from
ufw-reset:
  cmd.run:
    - name: sudo ufw --force reset

# Tell UFW to default to denying incoming connections
ufw-default-deny-incoming:
  cmd.run:
    - name: sudo ufw --force default deny incoming

# Tell UFW to default to allowing outgoing connections
ufw-default-allow-outgoing:
  cmd.run:
    - name: sudo ufw --force default allow outgoing

# Tell UFW to allow SSH
ufw-allow-ssh:
  cmd.run:
    - name: sudo ufw --force allow 'OpenSSH'

# Tell UFW to allow nginx
ufw-allow-nginx:
  cmd.run:
    - name: sudo ufw --force allow 'Nginx Full'

# Tell UFW to be enabled
ufw-enable:
  cmd.run:
    - name: sudo ufw --force enable
