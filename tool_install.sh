#!/bin/bash

#Colors
GREEN="\e[32m"
YELLOW="\e[33m"
NC="\e[0m"


echo -e ${GREEN}"[+] Updateing system..."${NC}
sudo apt-get -y update

echo -e ${GREEN}"[+] unziping Rockyou.txt..."${NC}
unzip -d usr/share/wordlists/rockyou.txt.zip

echo -e ${GREEN}"[+] Installing Terminator..."${NC}
sudo apt-get -y install terminator

echo -e ${GREEN}"[+] installing batcat..."${NC}
sudo apt-get -y install bat

echo -e ${GREEN}"[+] Installing command line history search..."${NC}
sudo git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

echo -e ${GREEN}"[+] Installing Rustscan..."${NC}
sudo https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb && dpkg -i /home/$USER/downloads/rustscan_2.0.1_amd64.deb 

echo -e ${GREEN}"[+] Installing wfuzz..."${NC}
sudo apt-get -y install wfuzz

echo -e ${GREEN}"[+] Installing fuff..."${NC}
sudo apt-get -y install ffuf

echo -e ${GREEN}"[+] Installing seclists..."${NC}
sudo apt-get -y install seclists

echo -e ${GREEN}"[+] Installing Bloodhound..."${NC}
sudo apt-get -y install bloodhound

echo -e ${GREEN}"[+] Installing Neo4j..."${NC}
sudo apt-get -y install neo4j
echo ""
echo ""
echo -e ${YELLOW}"-------------------------------------------"
echo "Add this to your .zshrc file"
echo "Alias cat='batcat'"
echo "-------------------------------------------"${NC}
