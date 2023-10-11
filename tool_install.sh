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
startdir=$(pwd)

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
# INSTALING TOOLLS
###########################################################################

#Fuction for Installing tools, and then calling the function via the menu
install_tools() {
echo -e ${GREEN}"------------------------------------------"
echo -e ${GREEN}"[*] Installing tools"
echo -e ${GREEN}"------------------------------------------"

#Unpacking Rockyou.txt.gz
if [[ $(ls /usr/share/wordlists | grep rock) == 'rockyou.txt' ]]; then
	printf "${GREEN}[+]${GREEN} %-20s %s\n" "Rockyou.txt" "Already unpacked"

else
	echo -e "${GREEN}[*]${YELLOW} Unpacking Rockyou.txt"
	gunzip /usr/share/wordlists/rockyou.txt.gz >/dev/null 2>&1
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

# Installing Better command-line reverse search function
if [[ $(which fzf) == /${user_name}'/.fzf/bin/fzf' ]]; then
	printf "${GREEN}[+]${GREEN} %-20s %s\n" "Reverse command-line" "Already installed"

else
	echo -e "${GREEN}[*]${YELLOW} Installing better reverse command-line history search"
	sudo git clone -q --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install >/dev/null 2>&1
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
#Crerating tools directory
tooldir="/${user_name}/tools"
echo -e ${GREEN}"------------------------------------------"
echo -e "${GREEN}[+] Creating Tools directory ${BLUE}[${tooldir}]${NC}"
mkdir ${tooldir} 2>/dev/null
cd ${tooldir}
sleep 2

echo -e ${GREEN}"------------------------------------------"
echo -e ${GREEN}"[*] Downloading Scripts into ${BLUE}[${tooldir}]"
echo -e ${GREEN}"------------------------------------------"

#Downloading mimikatz.exe
echo -e "${GREEN}[+]${YELLOW} Downloading Mimikatz.exe${NC}"
wget https://github.com/gentilkiwi/mimikatz/releases/download/2.2.0-20220919/mimikatz_trunk.7z >/dev/null 2>&1
7z e *.7z -y >/dev/null 2>&1
rm -rf /root/tools/x64 >/dev/null
rm -rf /root/tools/Win32 >/dev/null
mv mimikatz.exe dog.exe
rm -rf mimi*
rm -rf kiwi*
rm -rf README.md
mv dog.exe mimikatz.exe

#Downloading SharpHound.ps1
echo -e "${GREEN}[+]${YELLOW} Downloading SharpHound.ps1${NC}"
wget -q https://raw.githubusercontent.com/BloodHoundAD/BloodHound/master/Collectors/SharpHound.ps1 >/dev/null 2>&1

#Downloading SharpHound.exe
echo -e "${GREEN}[+]${YELLOW} Downloading SharpHound.exe${NC}"
wget -q https://github.com/BloodHoundAD/BloodHound/raw/master/Collectors/SharpHound.exe >/dev/null 2>&1

#Downloading winPEASx64.exe
echo -e "${GREEN}[+]${YELLOW} Downloading winPEASx64.exe${NC}"
wget -q https://github.com/carlospolop/PEASS-ng/releases/download/20230917-ec588706/winPEASx64.exe >/dev/null 2>&1

#Downloading winPEASany.exe
echo -e "${GREEN}[+]${YELLOW} Downloading winPEASany.exe${NC}"
wget -q https://github.com/carlospolop/PEASS-ng/releases/download/20230917-ec588706/winPEASany.exe >/dev/null 2>&1

#Downloading linPEAS.sh
echo -e "${GREEN}[+]${YELLOW} Downloading linPEAS.sh${NC}"
wget -q https://github.com/carlospolop/PEASS-ng/releases/download/20230917-ec588706/linpeas.sh >/dev/null 2>&1

#Downloading Powerview.ps1
echo -e "${GREEN}[+]${YELLOW} Downloading PowerView.ps1${NC}"
wget -q https://github.com/PowerShellMafia/PowerSploit/raw/master/Recon/PowerView.ps1 >/dev/nul 2>&1

#Downloading PowerUp.ps1
echo -e "${GREEN}[+]${YELLOW} Downloading PowerUp.ps1${NC}"
wget -q https://github.com/PowerShellMafia/PowerSploit/raw/master/Privesc/PowerUp.ps1 >/dev/null 2>&1

#Downloading Rubeus.exe
echo -e "${GREEN}[+]${YELLOW} Downloading Rubeus.exe${NC}"
wget -q https://github.com/r3motecontrol/Ghostpack-CompiledBinaries/raw/master/Rubeus.exe >/dev/null 2>&1

#Downloading Inveigh.exe
echo -e "${GREEN}[+]${YELLOW} Downloading Inveigh.exe${NC}"
wget -q https://github.com/Kevin-Robertson/Inveigh/releases/download/v2.0.10/Inveigh-net3.5-v2.0.10.zip >/dev/null 2>&1
unzip -qq *.zip 2>/dev/null
rm *.zip
rm *.config
rm *.pdb

#Downloading Invegih.ps1
echo -e "${GREEN}[+]${YELLOW} Downloading Inveigh.ps1${NC}"
wget -q https://github.com/Kevin-Robertson/Inveigh/raw/master/Inveigh.ps1

#Downloading Microsoft sysinternal PSTools
echo -e "${GREEN}[+]${YELLOW} Downloading Microsoft Sysinternals PSTools${NC}"
wget -q https://download.sysinternals.com/files/PSTools.zip
unzip -qq *.zip 2>/dev/null
rm *.zip
echo -e "${GREEN}[+] ${BLUE}DONE!"${NC}
echo ""
cd ${startdir}
}

#Adding custom server to server tools to ~/.bashrc
custom_server() {


if [[ $(cat ~/.zshrc | grep -o 'servtools()') == 'servtools()' ]]; then
	echo -e "${GREEN}[+]${GREEN} servtools already installed"

else
	echo -e "${GREEN}[*]${YELLOW} Adding servtools to ${user_name}/.zshrc file}"

	echo -e ${GREEN}"----------------------------------------------"
	echo -e "${GREEN}[+]${YELLOW} Adding servtools script to: ${BLUE}~/.zshrc"${NC}
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
	echo '    DIR="/root/tools"' >> ~/.zshrc 2>/dev/null
	echo "    IP=\$(ip -4 addr show tun0 | grep -oP \"(?<=inet ).*(?=/)\")" >> ~/.zshrc 2>/dev/null
	echo '    echo -e "${GREEN}Files in serving directory [${DIR}]${NC}"' >> ~/.zshrc 2>/dev/null
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
}

#Check if the user is running as root, if not exit and telle the user run the script with sudo.
if [[ $EUID -ne 0 ]]; then
   echo -e "${BLUE}You need to run this script with sudo${NC}"
   exit 1
fi

# Ask the user if they want to update the system
echo -e "${GREEN}[?]${YELLOW} Do you want to update the system? (y/N)${NC}"
read -r update_choice

if [[ $update_choice == "y" || $update_choice == "Y" ]]; then
    echo -e "${GREEN}[*]${YELLOW} Updating System${NC}"
    sudo apt-get -qq -y update 2>/dev/null 2>&1
    
    # After update is complete, ask if they want to continue
    echo -e "${GREEN}[?]${YELLOW} Update complete! Do you want to continue? (y/N)${NC}"
    read -r continue_choice
    
    if [[ $continue_choice != "y" && $continue_choice != "Y" ]]; then
        echo -e "${GREEN}[+]${YELLOW} Exiting script${NC}"
        exit 0
    fi
    
else
    echo -e "${GREEN}[*]${YELLOW} Skipping System Update${NC}"
    echo ""
fi

# Function to display menu and prompt for user's choice.
menu_choice() {
    echo -e "${GREEN}[*] ${BLUE}Choose an option:${NC}"
    echo -e "${GREEN}[1]${YELLOW} Install Tools${NC}"
    echo -e "${GREEN}[2]${YELLOW} Download Scripts${NC}"
    echo -e "${GREEN}[3]${YELLOW} Install Custom server${NC}"
    echo -e "${GREEN}[4]${YELLOW} Install all above${NC}"
    echo -e "${GREEN}[0]${YELLOW} Exit${NC}"

    read -p "Enter choice [1-4]: [0] To Exit: " choice

    case $choice in
        1) install_tools ;;
        2) download_scripts ;;
        3) custom_server ;;
        4) 
            install_tools
            download_scripts
            custom_server
            ;;
        0) 
            echo -e "${GREEN}[+] Exiting...${NC}"
            exit 0
            ;;
        *) 
            echo -e "${RED}[!] Invalid option. Please choose a number between 0-4.${NC}"
            menu_choice
            ;;
    esac
}

menu_choice
