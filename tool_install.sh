#!/bin/bash

#Colors
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
RED="\e[31m"
ORANGE="\e[93m"
INDIGO="\e[94m"
VIOLET="\e[35m"
LIGHT_BLUE="\e[38;5;39m"
NC="\e[0m"

user_name=$(whoami)
user_name2=${SUDO_USER}
user_home=$HOME
startdir=$(pwd)

user_home2=$(while IFS=: read -r user _ uid _ _ home _; do
    if [[ $user == "$SUDO_USER" ]] && { [[ $uid -eq 0 ]] || [[ $uid -ge 1000 && $uid -lt 2000 ]]; }; then
        echo -e "${home}"
    fi
done < /etc/passwd)

# Display the result
#echo "$user_home2"

echo ""
echo -e ${GREEN}" Created by:"
echo -e " ${RED}   ___              _                     _     "
echo -e " ${YELLOW}  / _ \            | |                   | |    "
echo -e " ${ORANGE} | | | |__  __ ___ | |_  __ _  __ __ ___ | | __ "
echo -e " ${BLUE} | | | |\ \/ // __|| __|/ _\ |/ _\ || __|| |/ / "
echo -e " ${LIGHT_BLUE} | |_| | >  < \__ \| |_| (_| ||(_| || |  |   <  "
echo -e " ${VIOLET}  \___/ /_/\_\|___/ \__|\__,_|\__,_||_|  |_|\_\ "
echo ""
echo -e "${BLUE}https://github.com/0xstaark"${NC}
echo ""

###########################################################################
# System Update
###########################################################################

update_system() {
echo -e "${YELLOW}[!] To update the system you need to run with SUDO"${NC}
sudo -v
sudo apt-get -qq -y update >/dev/null 2>&1
echo -e "${GREEN}[!] System update complete"
}

###########################################################################
# INSTALING TOOLLS
###########################################################################

#Fuction for Installing tools, and then calling the function via the menu
install_tools() {
echo -e "${YELLOW}[!] To install the tools you need to run with SUDO"${NC}
sudo -v
echo -e ${GREEN}"-----------------------------------------------------"
echo -e ${GREEN}"[*] Installing tools"
echo -e ${GREEN}"-----------------------------------------------------"

#Unpacking Rockyou.txt.gz
if [[ $(ls /usr/share/wordlists | grep rockyou.txt) == 'rockyou.txt' ]]; then
	printf "${GREEN}[+]${GREEN} %-20s %s\n" "Rockyou.txt" "Already unpacked"

else
	echo -e "${GREEN}[*]${YELLOW} Unpacking Rockyou.txt"
	gunzip /usr/share/wordlists/rockyou.txt.gz -y >/dev/null 2>&1
	rm -r /usr/share/wordlists/rockyou.txt.gz
fi

#Installing seclists
if [[ $(ls /usr/share | grep seclists) == 'seclists' ]]; then
	printf "${GREEN}[+]${GREEN} %-20s %s\n" "seclists" "Already installed"

else
	echo -e "${GREEN}[*]${YELLOW} Installing seclists"
	sudo apt-get -qq -y install seclists >/dev/null 2>&1
fi

#Installing Terminator
if [[ $(which terminator) == '/usr/bin/terminator' ]]; then
	printf "${GREEN}[+]${GREEN} %-20s %s\n" "Terminator" "Already installed"

else
	echo -e "${GREEN}[*]${YELLOW} Installing Terminator"
	sudo apt-get -qq -y install terminator >/dev/null 2>&1
fi

# Intalling batcat
if [[ $(which batcat) == '/usr/bin/batcat' ]]; then
	printf "${GREEN}[+]${GREEN} %-20s %s\n" "Batcat" "Already installed"

else
	echo -e "${GREEN}[*]${YELLOW} Installing batcat"
	sudo apt-get -qq -y install bat >/dev/null 2>&1
fi

#Intalling Rustscan
if [[ $(which rustscan) == '/usr/bin/rustscan' ]]; then
	printf "${GREEN}[+]${GREEN} %-20s %s\n" "Rustscan" "Already installed"

else
	echo -e "${GREEN}[*]${YELLOW} Installing Rustscan"
	sudo wget -q https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb && dpkg -i rustscan_2.0.1_amd64.deb >/dev/null 2>&1
	rm rustscan_2.0.1_amd64.deb >/dev/null >&1
fi

#Insatlling wfuzz
if [[ $(which wfuzz) == '/usr/bin/wfuzz' ]]; then
	printf "${GREEN}[+]${GREEN} %-20s %s\n" "wfuzz" "Already installed"

else
	echo -e "${GREEN}[*]${YELLOW} Installing wfuzz"
	sudo apt-get -qq -y install wfuzz >/dev/null 2>&1
fi

#Installing ffuf
if [[ $(which ffuf) == '/usr/bin/ffuf' ]]; then
	printf "${GREEN}[+]${GREEN} %-20s %s\n" "ffuf" "Already installed"

else
	echo -e "${GREEN}[*]${YELLOW} Installing ffuf"
	sudo apt-get -qq -y install ffuf >/dev/null 2>&1
fi

#Installing Bloodhound
if [[ $(which bloodhound) == '/usr/bin/bloodhound' ]]; then
	printf "${GREEN}[+]${GREEN} %-20s %s\n" "Bloodhound" "Already installed"

else
	echo -e "${GREEN}[*]${YELLOW} Installing bloodhound"
	sudo apt-get -qq -y install bloodhound >/dev/null 2>&1
fi

#Installing Neo4j
if [[ $(which neo4j) == '/usr/bin/neo4j' ]]; then
	printf "${GREEN}[+]${GREEN} %-20s %s\n" "Neo4j" "Already installed"

else
	echo -e "${GREEN}[*]${YELLOW} Installing Neo4j"
	sudo apt-get -qq -y install neo4j >/dev/null 2>&1
fi

#Installing GoBuster
if [[ $(which gobuster) == '/usr/bin/gobuster' ]]; then
	printf "${GREEN}[+]${GREEN} %-20s %s\n" "GoBuster" "Already installed"

else
	echo -e "${GREEN}[*]${YELLOW} Installing GoBuster"
	sudo apt-get -qq -y install gobuster >/dev/null 2>&1
fi

#Installing feroxbuster
if [[ $(which feroxbuster) == '/usr/bin/feroxbuster' ]]; then
	printf "${GREEN}[+]${GREEN} %-20s %s\n" "Feroxbuster" "Already installed"

else
	echo -e "${GREEN}[*]${YELLOW} Installing Feroxbuster"
	sudo apt-get -qq -y install feroxbuster >/dev/null 2>&1
fi
echo -e "[+] ${BLUE}DONE!"${NC}

}


###########################################################################
# DONWLOADING SCRIPTS
###########################################################################

#Fuction for dowloading scripts, and then calling the function via the menu
download_scripts() {

# Default directory
toolsdir="$HOME/tools"

# Prompt the user for a custom directory
echo -e "Choose directory to download Script to. Example ${YELLOW}/opt/tools${NC}"
echo ""
read -p "Enter the directory to use or ENTER for default: [${toolsdir}]: " userdir

# If user provides input, use it as the tools directory
if [[ -n "$userdir" ]]; then
    toolsdir="$userdir"
fi

# Check if directory exists
if [[ -d "$toolsdir" ]]; then
    echo -e ${YELLOW}"[!] Using directory ${BLUE}[${toolsdir}]${YELLOW}"
else
    echo -e ${GREEN}"Creating directory: [${BLUE}${toolsdir}${GREEN}]${NC}"
    mkdir -p "$toolsdir"
fi

# Change to the tools directory
cd "$toolsdir"
echo -e ${GREEN}"-----------------------------------------------------"
echo -e ${GREEN}"[*] Downloading Scripts into ${BLUE}[${toolsdir}]"
echo -e ${GREEN}"-----------------------------------------------------"
sleep 1


#Downloading mimikatz.exe
if [[ ! -f "mimikatz.exe" ]]; then
	printf "${GREEN}[+]${YELLOW} %-15s %s\n" "Downloading" "Mimikatz.exe"
	wget https://github.com/gentilkiwi/mimikatz/releases/download/2.2.0-20220919/mimikatz_trunk.7z >/dev/null 2>&1
	7z e *.7z -y >/dev/null 2>&1
	rm -rf ${toolsdir}/x64 >/dev/null
	rm -rf ${toolsdir}/Win32 >/dev/null
	mv mimikatz.exe dog.exe
	rm -rf mimi*
	rm -rf kiwi*
	rm -rf README.md
	mv dog.exe mimikatz.exe
else
	printf "${GREEN}[x] %-15s %s\n" "mimikatz.exe" "already exists. Skipping download"
fi

#Downloading SharpHound.ps1
if [[ ! -f "SharpHound.ps1" ]]; then
	printf "${GREEN}[+]${YELLOW} %-15s %s\n" "Downloading" "SharpHound.ps1"
	wget -q https://raw.githubusercontent.com/BloodHoundAD/BloodHound/master/Collectors/SharpHound.ps1 >/dev/null 2>&1
else
	printf "${GREEN}[x] %-15s %s\n" "SharpHound.ps1" "already exists. Skipping download"
fi

#Downloading SharpHound.exe
if [[ ! -f "SharpHound.exe" ]]; then
	printf "${GREEN}[+]${YELLOW} %-15s %s\n" "Downloading" "SharpHound.exe"
	wget -q https://github.com/BloodHoundAD/BloodHound/raw/master/Collectors/SharpHound.exe >/dev/null 2>&1
else
	printf "${GREEN}[x] %-15s %s\n" "SharpHound.exe" "already exists. Skipping download"
fi

#Downloading winPEASx64.exe
if [[ ! -f "winPEASx64.exe" ]]; then
	printf "${GREEN}[+]${YELLOW} %-15s %s\n" "Downloading" "winPEASx64.exe"
	wget -q https://github.com/carlospolop/PEASS-ng/releases/download/20230917-ec588706/winPEASx64.exe >/dev/null 2>&1
else
	printf "${GREEN}[x] %-15s %s\n" "winPEASx64.exe" "already exists. Skipping download"
fi

#Downloading winPEASany.exe
if [[ ! -f "winPEASany.exe" ]]; then
	printf "${GREEN}[+]${YELLOW} %-15s %s\n" "Downloading" "winPEASany.exe"
	wget -q https://github.com/carlospolop/PEASS-ng/releases/download/20230917-ec588706/winPEASany.exe >/dev/null 2>&1
else
	printf "${GREEN}[x] %-15s %s\n" "winPEASany.exe" "already exists. Skipping download"
fi

#Downloading linPEAS.sh
if [[ ! -f "linpeas.sh" ]]; then
	printf "${GREEN}[+]${YELLOW} %-15s %s\n" "Downloading" "linPEAS.sh"
	wget -q https://github.com/carlospolop/PEASS-ng/releases/download/20230917-ec588706/linpeas.sh >/dev/null 2>&1
else
	printf "${GREEN}[x] %-15s %s\n" "linPEAS.sh" "already exists. Skipping download"
fi

#Downloading Powerview.ps1
if [[ ! -f "PowerView.ps1" ]]; then
	printf "${GREEN}[+]${YELLOW} %-15s %s\n" "Downloading" "PowerView.ps1"
	wget -q https://github.com/PowerShellMafia/PowerSploit/raw/master/Recon/PowerView.ps1 >/dev/null 2>&1
else
	printf "${GREEN}[x] %-15s %s\n" "PowerView.ps1" "already exists. Skipping download"
fi

#Downloading PowerUp.ps1
if [[ ! -f "PowerUp.ps1" ]]; then
	printf "${GREEN}[+]${YELLOW} %-15s %s\n" "Downloading" "PowerUp.ps1"
	wget -q https://github.com/PowerShellMafia/PowerSploit/raw/master/Privesc/PowerUp.ps1 >/dev/null 2>&1
else
	printf "${GREEN}[x] %-15s %s\n" "PowerUp.ps1" "already exists. Skipping download"
fi

#Downloading Rubeus.exe
if [[ ! -f "Rubeus.exe" ]]; then
	printf "${GREEN}[+]${YELLOW} %-15s %s\n" "Downloading" "Rubeus.exe"
	wget -q https://github.com/r3motecontrol/Ghostpack-CompiledBinaries/raw/master/Rubeus.exe >/dev/null 2>&1
else
	printf "${GREEN}[x] %-15s %s\n" "Rubeus.exe" "already exists. Skipping download"
fi

#Downloading Inveigh.exe
if [[ ! -f "Inveigh.exe" ]]; then
	printf "${GREEN}[+]${YELLOW} %-15s %s\n" "Downloading" "Inveigh.exe"
	wget -q https://github.com/Kevin-Robertson/Inveigh/releases/download/v2.0.10/Inveigh-net3.5-v2.0.10.zip >/dev/null 2>&1
	unzip -qq *.zip 2>/dev/null
	rm *.zip
	rm *.config
	rm *.pdb
else
	printf "${GREEN}[x] %-15s %s\n" "Inveigh.exe" "already exists. Skipping download"
fi

#Downloading Invegih.ps1
if [[ ! -f "Inveigh.ps1" ]]; then
	printf "${GREEN}[+]${YELLOW} %-15s %s\n" "Downloading" "Inveigh.ps1"
	wget -q https://github.com/Kevin-Robertson/Inveigh/raw/master/Inveigh.ps1
else
	printf "${GREEN}[x] %-15s %s\n" "Inveigh.ps1" "already exists. Skipping download"
fi

#Downloading Microsoft sysinternal PSTools
if [[ ! -f "PsExec.exe" ]]; then
	printf "${GREEN}[+]${YELLOW} %-15s %s\n" "Downloading" "Microsoft Sysinternals PSTools"
	wget -q https://download.sysinternals.com/files/PSTools.zip
	unzip -qq *.zip 2>/dev/null
	rm *.zip
else
	printf "${GREEN}[x] %-15s %s\n" "PSTools" "already exists. Skipping download"
fi

#Downloading AutoRecon and installing requrements.
if [[ ! -d "AutoRecon" ]]; then
	printf "${GREEN}[+]${YELLOW} %-15s %s\n" "Downloading" "AutoRecon"
	git clone https://github.com/Tib3rius/AutoRecon.git 2>/dev/null
	pip install -r AutoRecon/requirements.txt >/dev/null 2>&1
else
	printf "${GREEN}[x] %-15s %s\n" "AutoRecon" "already exists. Skipping download"
fi

#Downloading nc64.exe
if [[ ! -f "nc64.exe" ]]; then
	printf "${GREEN}[+]${YELLOW} %-15s %s\n" "Downloading" "nc64.exe"
	wget -q https://github.com/int0x33/nc.exe/raw/master/nc64.exe
else
	printf "${GREEN}[x] %-15s %s\n" "nc64.exe" "already exists. Skipping download"
fi

#Downloading nc.exe
if [[ ! -f "nc.exe" ]]; then
	eprintf "${GREEN}[+]${YELLOW} %-15s %s\n" "Downloading" "nc.exe"
	wget -q https://github.com/int0x33/nc.exe/raw/master/nc.exe
else
	printf "${GREEN}[x] %-15s %s\n" "nc.exe" "already exists. Skipping download"
fi

#Downloading PlumHound.py
if [[ ! -f "PlumHound.py" ]]; then
	printf "${GREEN}[+]${YELLOW} %-15s %s\n" "Downloading" "PlumHound.py"
	wget -q https://github.com/PlumHound/PlumHound/raw/master/PlumHound.py
else
	printf "${GREEN}[x] %-15s %s\n" "PlumHound.py" "already exists. Skipping download"
fi

#Downloadning pspy32
if [[ ! -f "pspy32" ]]; then
	printf "${GREEN}[+]${YELLOW} %-15s %s\n" "Downloading" "pspy32"
	wget -q https://github.com/DominicBreuker/pspy/releases/download/v1.2.1/pspy32
else
	printf "${GREEN}[x] %-15s %s\n" "pspy32" "already exists. Skipping download"
fi

#Downloading pspy64
if [[ ! -f "pspy64" ]]; then
	printf "${GREEN}[+]${YELLOW} %-15s %s\n" "Downloading" "pspy64"
	wget -q https://github.com/DominicBreuker/pspy/releases/download/v1.2.1/pspy64
else
	printf "${GREEN}[x] %-15s %s\n" "pspy64" "already exists. Skipping download"
fi






echo -e "${BLUE}[!] ${BLUE}DONE!"${NC}
echo -e ${GREEN}"-----------------------------------------------------"
rm *.txt 2>/dev/null
rm *.chm 2>/dev/null
cd ${startdir}

###########################################################################
# Custom HTTP server from the tools directory
###########################################################################

#Adding custom server to server tools to ~/.bashrc
if [[ $(cat ~/.zshrc | grep -o 'servtools()') == 'servtools()' ]]; then
	echo -e "${GREEN}[+]${GREEN} servtools already installed"
	echo -e "${YELLOW}[!] To use this server, reopen terminal and type servetools <port>"

else
	echo -e "${YELLOW}[!] Adding a custom server for starting HTTP.server form the tools directory"
	echo -e "${YELLOW}[!] Adding servtools to ${user_home}/.zshrc file}"
	echo "" >> ~/.zshrc 2>/dev/null
	echo "" >> ~/.zshrc 2>/dev/null
	echo "" >> ~/.zshrc 2>/dev/null
	echo "" >> ~/.zshrc 2>/dev/null
	echo "# My personal configuration" >> ~/.zshrc 2>/dev/null
	echo "" >> ~/.zshrc 2>/dev/null
	echo "# Http server function which starts an http server from the /root/tools folder" >> ~/.zshrc 2>/dev/null
	echo "# Call this function using servtools <port>" >> ~/.zshrc 2>/dev/null
	echo "servtools() {" >> ~/.zshrc 2>/dev/null
	echo '    GREEN="\e[32m"' >> ~/.zshrc 2>/dev/null
	echo '    NC="\e[0m"' >> ~/.zshrc 2>/dev/null
	echo "    PORT=\$1" >> ~/.zshrc 2>/dev/null
	echo '    DIR="mySuperuniqvalue"' >> ~/.zshrc 2>/dev/null
	echo "    IP=\$(ip -4 addr show tun0 | grep -oP \"(?<=inet ).*(?=/)\")" >> ~/.zshrc 2>/dev/null
	echo '    echo -e "${GREEN}Files in directory ${BLUE}[${DIR}]${NC}"' >> ~/.zshrc 2>/dev/null
	echo '    ls ${DIR}' >> ~/.zshrc 2>/dev/null
	echo '    echo -e "${GREEN}-------------------------------------------------------------------------${NC}"' >> ~/.zshrc 2>/dev/null
	echo "    echo -e \"[+] Starting HTTP server from \${GREEN}[\$DIR]\${NC} on \$PORT\"" >> ~/.zshrc 2>/dev/null
	echo "    echo -e \"[+] Address: http://\$IP:\$PORT/\"" >> ~/.zshrc 2>/dev/null
	echo "    python3 -m http.server \$PORT --directory \$DIR" >> ~/.zshrc 2>/dev/null
	echo '}' >> ~/.zshrc 2>/dev/null
	echo "" >> ~/.zshrc 2>/dev/null
	echo "" >> ~/.zshrc 2>/dev/null
	echo "# Better cat (batcat)" >> ~/.zshrc 2>/dev/null
	echo "alias cat='batcat'" >> ~/.zshrc 2>/dev/null
	source ~/.zshrc 2>/dev/null
fi
sed -i 's@DIR="mySuperuniqvalue"@DIR="'${toolsdir}'"@' ~/.zshrc
}



###########################################################################
# Menu Function
###########################################################################

# Function to display menu and prompt for user's choice.
menu_choice() {
    echo -e "${GREEN}[?]${BLUE} Choose an option:${NC}"
    echo -e "${GREEN}[1]${YELLOW} Update System${NC}"
    echo -e "${GREEN}[2]${YELLOW} Install Tools${NC}"
    echo -e "${GREEN}[3]${YELLOW} Download Scripts${NC}"
    echo -e "${GREEN}[4]${YELLOW} Install tools and Download scripts${NC}"
    echo -e "${GREEN}[5]${YELLOW} All the above${NC}"
    echo -e "${GREEN}[0]${YELLOW} Exit${NC}"

    read -p "Enter choice [1-5]: [0] To Exit: " choice

    case $choice in
    	1) update_system ;;
        2) install_tools ;;
        3) download_scripts ;;
        4) 
            install_tools
            download_scripts
            ;;
	5)  
	    update_system 
	    install_tools
            download_scripts
            ;;
        0) 
            echo -e "${GREEN}[+] Exiting...${NC}"
            exit 0
            ;;
        *) 
            echo -e "${RED}[!] Invalid option. Please choose a number between 0-5.${NC}"
            menu_choice
            ;;
    esac
}

menu_choice
