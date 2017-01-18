#Import public key for the package
mongo-import:
  cmd.run:
    - name: sudo apt-key adv --keyserver {{ pillar['MONGODB_KEYSERVER'] }} --recv {{ pillar['MONGODB_GPG_KEY'] }}

#Create the list file for mongodb. Gets the right version for this version of Ubuntu
mongo-create-list:
  cmd.run:
    {% if grains['oscodename'] == 'xenial' %}
    - name: echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu {{ salt['grains.get']('oscodename', '') }}/mongodb-org/{{ pillar['MONGODB_VERSION'] }} multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-{{ pillar['MONGODB_VERSION'] }}.list
    {% else %}
    - name: echo "deb [ arch=amd64 ] http://repo.mongodb.org/apt/ubuntu {{ salt['grains.get']('oscodename', '') }}/mongodb-org/{{ pillar['MONGODB_VERSION'] }} multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-{{ pillar['MONGODB_VERSION'] }}.list
    {% endif %}

#Apt-key Update
mongo-key-update:
  cmd.run:
    - name: sudo apt-key update

#Apt-get Clean
mongo-clean:
  cmd.run:
    - name: sudo apt-get clean

#Apt-get Update
mongo-update:
  cmd.run:
    - name: sudo apt-get update

#Install
mongo-install:
  cmd.run:
    - name: sudo apt-get install -y mongodb-org

# Use mongodb.conf
mongo-configuration-file:
  file.managed:
    - name: /etc/mongod.conf
    - source: salt://mongodb/mongod.conf

# Make sure mongodb is running, restart if we changed mongod.conf
mongo-startup:
  service.running:
    - name: mongod
    - watch:
      - file: /etc/mongod.conf
