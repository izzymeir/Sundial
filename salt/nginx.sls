nginx:
  pkg.installed:
    - name: nginx
  service.running:
    - name: nginx
    - require:
      - pkg: nginx
