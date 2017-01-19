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

# Run a script that handles configuration of the firewall
ufw-script:
  cmd.script:
    - source: salt://ufw/firewall_settings.sh
