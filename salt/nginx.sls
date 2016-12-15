nginx:
  pkg.installed:
    - nginx
  service.running:
    - name: nginx
