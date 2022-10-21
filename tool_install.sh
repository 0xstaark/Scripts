#!/bin/bash


echo "[+] Updateing system..."
sudo apt-get -y update

echo "unziping Rockyou.txt..."
unzip -d usr/share/wordlists/rockyou.txt.zip

echo "[+] Installing Terminator..."
sudo apt-get -y install terminator

echo "[+] installing batcat..."
sudo apt-get -y install bat

echo "[+] Installing command line history search..."
sudo git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

echo "[+] Installing Rustscan..."
sudo https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb && dpkg -i rustscan_2.0.1_amd64.deb 

echo "[+] Installing wfuzz..."
sudo apt-get -y install wfuzz

echo "[+] Installing fuff..."
sudo apt-get -y install ffuf

echo "[+] Installing seclists..."
sudo apt-get -y install seclists

echo "[+] Installing Bloodhound..."
sudo apt-get -y install bloodhound

echo "[+] Installing Neo4j..."
sudo apt-get -y install neo4j
echo ""
echo ""
echo "-------------------------------------------"
echo "Add this to your .zshrc file"
echo "Alias cat='batcat'"
echo "-------------------------------------------"
