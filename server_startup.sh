#!/bin/bash
apt update
apt install -y wget
wget "https://raw.githubusercontent.com/souravdatta/msngr/main/server.pl"
wget "https://raw.githubusercontent.com/souravdatta/msngr/main/demon.pl"
perl demon.pl
echo "++++++startup done++++++"

