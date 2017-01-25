#!/bin/sh

# Copy the salt and pillar files to their correct directories
sudo cp -r salt /srv
sudo cp -r pillar /srv

# Tell Salt to apply the highstate in top.sls
sudo salt-call --local state.apply

echo "DONE apply_top.sh DONE\n"
