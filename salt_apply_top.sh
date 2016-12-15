#!/bin/sh
# Copy the salt and pillar files to their correct directories, and tell Salt to apply the highstate in top.sls
sudo cp -r salt/* /srv/salt
sudo cp -r pillar/* /srv/pillar
sudo salt-call --local state.apply
echo "DONE\n"
