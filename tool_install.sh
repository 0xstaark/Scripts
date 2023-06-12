#!/bin/bash

#Colors
GREEN="\e[32m"
YELLOW="\e[33m"
NC="\e[0m"

echo -e ${YELLOW}"----------------------------------------------"
echo -e "${GREEN}[+]${NC} ${YELLOW}Updateing system"
echo -e "----------------------------------------------"${NC}
#sudo apt-get -y update 2>/dev/null

echo -e ${YELLOW}"----------------------------------------------"
echo -e "${GREEN}[+]${NC} ${YELLOW}Unziping Rockyou.txt"
echo -e "----------------------------------------------"${NC}
gunzip /usr/share/wordlists/rockyou.txt.zip 2>/dev/null

echo -e ${YELLOW}"----------------------------------------------"
echo -e "${GREEN}[+]${NC} ${YELLOW}Installing Terminator"
echo -e "----------------------------------------------"${NC}
sudo apt-get -y install terminator 2>/dev/null

echo -e ${YELLOW}"----------------------------------------------"
echo -e "${GREEN}[+]${NC} ${YELLOW}Installing batcat"
echo -e "----------------------------------------------"${NC}
sudo apt-get -y install bat 2>/dev/null

echo -e ${YELLOW}"----------------------------------------------"
echo -e "${GREEN}[+]${NC} ${YELLOW}Installing command line history search"
echo -e "----------------------------------------------"${NC}
sudo git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install 2>/dev/null

echo -e ${YELLOW}"----------------------------------------------"
echo -e "${GREEN}[+]${NC} ${YELLOW}Installing Rustscan"
echo -e "----------------------------------------------"${NC}
sudo wget https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb && dpkg -i rustscan_2.0.1_amd64.deb 2>/dev/null
echo -e ${YELLOW}"----------------------------------------------"
echo -e "${GREEN}[+]${NC} ${YELLOW}Removing Rustscan install file"${NC}
echo -e "${YELLOW}----------------------------------------------"${NC}
rm rustscan_2.0.1_amd64.deb

echo -e ${YELLOW}"----------------------------------------------"
echo -e "${GREEN}[+]${NC} ${YELLOW}Installing wfuzz"
echo -e "----------------------------------------------"${NC}
sudo apt-get -y install wfuzz 2>/dev/null

echo -e ${YELLOW}"----------------------------------------------"
echo -e "${GREEN}[+]${NC} ${YELLOW}Installing fuff"
echo -e "----------------------------------------------"${NC}
sudo apt-get -y install ffuf 2>/dev/null

echo -e ${YELLOW}"----------------------------------------------"
echo -e "${GREEN}[+]${NC} ${YELLOW}Installing seclists"
echo -e "----------------------------------------------"${NC}
sudo apt-get -y install seclists 2>/dev/null

echo -e ${YELLOW}"----------------------------------------------"
echo -e "${GREEN}[+]${NC} ${YELLOW} Installing Bloodhound"
echo -e "----------------------------------------------"${NC}
sudo apt-get -y install bloodhound 2>/dev/null

echo -e ${YELLOW}"----------------------------------------------"
echo -e "${GREEN}[+]${NC} ${YELLOW} Installing Neo4j"
echo -e "----------------------------------------------"${NC}
sudo apt-get -y install neo4j 2>/dev/null
echo ""
echo -e ${GREEN}"----------------------------------------------"
echo -e "[+] DONE!"
echo -e "----------------------------------------------"${NC}
echo ""
echo -e ${YELLOW}"----------------------------------------------"
echo "Add this to your .zshrc file"
echo "Alias cat='batcat'"
echo "----------------------------------------------"
