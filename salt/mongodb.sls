mongodb:
  #Import public key for the package
  import-key:
    cmd.run:
      - name: |
        sudo apt-key adv --keyserver {{ pillar['MONGODB_KEYSERVER'] }} --recv {{ pillar['MONGODB_GPG_KEY'] }}
        touch MONGODB_PACK_KEY_ADDED
      - creates: MONGODB_PACK_KEY_ADDED

  #Create the list file for mongodb. Gets the right version for this version of Ubuntu
  create-list:
    cmd.run:
      - name: |
        {% set os_codename = salt['grains.get']('oscodename', '') %}
        echo "deb http://repo.mongodb.org/apt/ubuntu {{ os_codename }}/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
        touch MONGODB_PACK_LIST_CREATED
      - creates: MONGODB_PACK_LIST_CREATED

  #Install the packages
  install-packages:
    cmd.run:
      - name: |
        sudo apt-get update
        sudo apt-get install -y mongodb-org
        touch MONGODB_INSTALLED
      - creates: MONGODB_INSTALLED
      - require:
        - file: MONGODB_PACK_KEY_ADDED
        - file: MONGODB_PACK_LIST_CREATED
        - file: MONGODB_THIS_FILE_DOESNT_EXIST
