#!/bin/sh

#Make sure that the salt and pillar directories are there
sudo mkdir /srv/salt
sudo mkdir /srv/pillar

# Copy the salt and pillar files to their correct directories
sudo cp -r salt/* /srv/salt
sudo cp -r pillar/* /srv/pillar

# Tell Salt to apply the highstate in top.sls
sudo salt-call --local state.apply

echo "DONE\n"
