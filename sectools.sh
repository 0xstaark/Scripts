#!/bin/bash


#Colors
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
RED="\e[31m"
ORANGE="\e[93m"
VIOLET="\e[35m"
LIGHT_BLUE="\e[38;5;39m"
NC="\e[0m"

#Environment variables
user_home=$HOME
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


###################################################################################################################
# Check network connection
###################################################################################################################

if ! ping -c 1 8.8.8.8 &> /dev/null; then
	echo ${RED}"No network connection. Exiting..."${NC}
	exit 1
fi


###################################################################################################################
# function to check for latest release of a file and download the file from GitHub if needed a newer version is avilable
###################################################################################################################
check_and_download_file() {
    local api_url="$1"
    local file_url="$2"
    local local_file="$3"

    # Get the time from the GitHub API
    github_time=$(curl -s "$api_url" | grep 'updated_at' | head -1 | sed 's/ //g' | awk -F '"' '{print $4}' | sed 's/T02.*//')

    # Check if the file exists locally
    if [[ -f "$local_file" ]]; then
        # Get the time from the local file
        local_time=$(stat -c "%y" "$local_file" 2>/dev/null | awk '{print $1}')

        # Convert the times to timestamps
        github_timestamp=$(date -d "$github_time" +%s)
        local_timestamp=$(date -d "$local_time" +%s)

        # Compare the timestamps to identify the newest file
        if [ "$github_timestamp" -gt "$local_timestamp" ]; then
            # Download the file
            wget -q "$file_url" -O "$local_file" >/dev/null 2>&1
            if [[ -f "$local_file" ]]; then
                printf "${GREEN}[+] %-15s %s\n" "Downloading:" "$local_file"
            else
                printf "${RED}[x] %-15s %s\n" "Failed to download:" "$local_file"
            fi
        else
            echo -e ${GREEN}"[*] You already have the newest version of:" ${YELLOW}"$local_file"${NC}
        fi
    else
        # If the file doesn't exist, download it
        wget -q "$file_url" -O "$local_file" >/dev/null 2>&1
        if [[ -f "$local_file" ]]; then
            printf "${GREEN}[+] %-15s %s\n" "Downloading:" "$local_file"
        else
            printf "${RED}[x] %-15s %s\n" "Failed to download:" "$local_file"
        fi
    fi
}


###################################################################################################################
# function to check for latest version of a single file, and download if it's a newer version.
###################################################################################################################
single_file_check_and_download_file() {
    local download_url="$1"
    local file1="$2"


    # Get the time from the GitHub API
    github_time=$(curl -s $download_url | grep 'created_at' | sed 's/ //g' | awk -F '"' '{print $4}' | sed 's/T.*//')

    # Check if file exists
    if [[ -f "$file1" ]]; then
        # Get the time from the local file
        local_file=$(stat -c "%y" "$file1" 2>/dev/null | awk '{print $1}')  
    
        # Convert the times to timestamps
        github_timestamp=$(date -d "$github_time" +%s)
        local_timestamp=$(date -d "$local_file" +%s)

        # Compare the timestamps to identify the newest file
        if [ "$github_timestamp" -gt "$local_timestamp" ]; then
            # Download file
    	    wget -q "$download_url" >/dev/null 2>&1
	    if [[ -f $file1 ]]; then
	        printf "${GREEN}[+] %-15s %s\n" "Downloading:" "$file1"	
	    else
                printf "${RED}[x] %-15s %s\n" "Failed to download:" "$file1"
            fi
        else 
            echo -e ${GREEN}"[*] You already have the newest version of:" ${YELLOW}"$local_file"${NC}
        fi
    else
        # If the file doesn't exist, download it
        wget -q "$download_url" >/dev/null 2>&1
        if [[ -f $file1 ]]; then
	    printf "${GREEN}[+] %-15s %s\n" "Downloading:" "$file1"	
        else
            printf "${RED}[x] %-15s %s\n" "Failed to download:" "$file1"
        fi
    fi
}


###################################################################################################################
# INSTALING TOOLLS
###################################################################################################################
#Fuction for Installing tools, and then calling the function via the menu
install_tools() {

# Check if user is NOT root
if [[ $UID -ne 0 ]]; then
	echo -e "${YELLOW}[!] To install the tools you need to run with SUDO"${NC}
        # Ensure the user can sudo or exit
        sudo -v || exit 1
fi

echo -e ${GREEN}"-----------------------------------------------------"
echo -e ${GREEN}"[*] Installing tools"
echo -e ${GREEN}"-----------------------------------------------------"

#Unpacking Rockyou.txt.gz
if [[ $(ls /usr/share/wordlists | grep rockyou.txt) == 'rockyou.txt' ]]; then
	printf "${GREEN}[+]${GREEN} %-15s %s\n" "Rockyou.txt" "Already unpacked"

else
	printf "${GREEN}[*]${YELLOW} %-15s %s\n" "Unpacking" "Rockyou.txt"
	gunzip /usr/share/wordlists/rockyou.txt.gz -y >/dev/null 2>&1
	rm -r /usr/share/wordlists/rockyou.txt.gz
fi


#Installing seclists
if [[ $(ls /usr/share | grep seclists) == 'seclists' ]]; then
	printf "${GREEN}[+]${GREEN} %-15s %s\n" "seclists" "Already installed"

else
	printf "${GREEN}[*]${YELLOW} %-15s %s\n" "Installing" "seclists"
	sudo apt-get -qq -y install seclists >/dev/null 2>&1
fi


#Installing Terminator
if [[ $(which terminator) == '/usr/bin/terminator' ]]; then
	printf "${GREEN}[+]${GREEN} %-15s %s\n" "Terminator" "Already installed"

else
	printf "${GREEN}[*]${YELLOW} %-15s %s\n" "Installing" "Terminator"
	sudo apt-get -qq -y install terminator >/dev/null 2>&1
fi


# Intalling batcat
if [[ $(which batcat) == '/usr/bin/batcat' ]]; then
	printf "${GREEN}[+]${GREEN} %-15s %s\n" "Batcat" "Already installed"

else
	printf "${GREEN}[*]${YELLOW} %-15s %s\n" "Installing" "batcat"
	sudo apt-get -qq -y install bat >/dev/null 2>&1
fi


#Intalling Rustscan
if [[ $(which rustscan) == '/usr/bin/rustscan' ]]; then
	printf "${GREEN}[+]${GREEN} %-15s %s\n" "Rustscan" "Already installed"

else
	printf "${GREEN}[*]${YELLOW} %-15s %s\n" "Installing" "Rustscan"
	sudo wget -q https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb && dpkg -i rustscan_2.0.1_amd64.deb >/dev/null 2>&1
	rm rustscan_2.0.1_amd64.deb >/dev/null >&1
fi


#Insatlling wfuzz
if [[ $(which wfuzz) == '/usr/bin/wfuzz' ]]; then
	printf "${GREEN}[+]${GREEN} %-15s %s\n" "wfuzz" "Already installed"

else
	printf "${GREEN}[*]${YELLOW} %-15s %s\n" "Installing" "wfuzz"
	sudo apt-get -qq -y install wfuzz >/dev/null 2>&1
fi


#Installing ffuf
if [[ $(which ffuf) == '/usr/bin/ffuf' ]]; then
	printf "${GREEN}[+]${GREEN} %-15s %s\n" "ffuf" "Already installed"

else
	printf "${GREEN}[*]${YELLOW} %-15s %s\n" "Installing" "ffuf"
	sudo apt-get -qq -y install ffuf >/dev/null 2>&1
fi


#Installing Bloodhound
if [[ $(which bloodhound) == '/usr/bin/bloodhound' ]]; then
	printf "${GREEN}[+]${GREEN} %-15s %s\n" "Bloodhound" "Already installed"

else
	printf "${GREEN}[*]${YELLOW} %-15s %s\n" "Installing" "bloodhound"
	sudo apt-get -qq -y install bloodhound >/dev/null 2>&1
fi


#Installing Neo4j
if [[ $(which neo4j) == '/usr/bin/neo4j' ]]; then
	printf "${GREEN}[+]${GREEN} %-15s %s\n" "Neo4j" "Already installed"

else
	printf "${GREEN}[*]${YELLOW} %-15s %s\n" "Installing" "Neo4j"
	sudo apt-get -qq -y install neo4j >/dev/null 2>&1
fi


#Installing GoBuster
if [[ $(which gobuster) == '/usr/bin/gobuster' ]]; then
	printf "${GREEN}[+]${GREEN} %-15s %s\n" "GoBuster" "Already installed"

else
	printf "${GREEN}[*]${YELLOW} %-15s %s\n" "Installing" "GoBuster"
	sudo apt-get -qq -y install gobuster >/dev/null 2>&1
fi


#Installing feroxbuster
if [[ $(which feroxbuster) == '/usr/bin/feroxbuster' ]]; then
	printf "${GREEN}[+]${GREEN} %-15s %s\n" "Feroxbuster" "Already installed"

else
	printf "${GREEN}[*]${YELLOW} %-15s %s\n" "Installing" "Feroxbuster"
	sudo apt-get -qq -y install feroxbuster >/dev/null 2>&1
fi
echo -e "${BLUE}[!] DONE!"${NC}

}


###################################################################################################################
# DONWLOADING SCRIPTS
###################################################################################################################

#Fuction for dowloading scripts, and then calling the function via the menu
download_scripts() {

# Default directory
toolsdir="$HOME/tools"

# Prompt the user for a custom directory
echo -e "Choose directory to download Script to. Example ${YELLOW}/opt/tools${NC}"
read -p "Enter the directory to use, hit ENTER for default: [${toolsdir}]: " userdir

# If user provides input, use it as the tools directory
if [[ -n "$userdir" ]]; then
    toolsdir="$userdir"
fi

# Check if directory exists
if [[ -d "$toolsdir" ]]; then
    echo -e ${YELLOW}"[!] Using directory: ${BLUE}[${toolsdir}]${YELLOW}"
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

#Downloading mimikatz
# GitHub API URL for the latest release
api_url="https://api.github.com/repos/gentilkiwi/mimikatz/releases/latest"
file="https://github.com/gentilkiwi/mimikatz/releases/download/.*/mimikatz_trunk.zip"
file1="mimikatz.exe"
check_and_download_file "$api_url" "$file" "$file1"


#Downloading SharpHound.ps1
# GitHub API URL for the latest release
api_url="https://api.github.com/repos/BloodHoundAD/SharpHound/releases/latest"
file="https://github.com/BloodHoundAD/SharpHound/releases/download/.*/SharpHound-v[0-9]+\.[0-9]+\.[0-9]+\.zip"
file1="SharpHound.exe"
check_and_download_file "$api_url" "$file" "$file1"


#Downloading winPEASx64.exe
# GitHub API URL for the latest release
api_url="https://api.github.com/repos/carlospolop/PEASS-ng/releases/latest"
file="https://github.com/carlospolop/PEASS-ng/releases/download/.*/winPEASx64.exe"
file1="winPEASx64.exe"
check_and_download_file "$api_url" "$file" "$file1"


#Downloading winPEASany.exe
# GitHub API URL for the latest release
api_url="https://api.github.com/repos/carlospolop/PEASS-ng/releases/latest"
file="https://github.com/carlospolop/PEASS-ng/releases/download/.*/winPEASany.exe"
file1="winPEASany.exe"
check_and_download_file "$api_url" "$file" "$file1"


#Downloading Linpeas.sh
# GitHub API URL for the latest release
api_url="https://api.github.com/repos/carlospolop/PEASS-ng/releases/latest"
file="https://github.com/carlospolop/PEASS-ng/releases/download/.*/linpeas.sh"
file1="linpeas.sh"
check_and_download_file "$api_url" "$file" "$file1"


#Downloading Powerview.ps1
download_url="https://github.com/PowerShellMafia/PowerSploit/raw/master/Recon/PowerView.ps1"
file1="PowerView.ps1"
single_file_check_and_download_file "$download_url" "$file1"
    

#Downloading PowerUp.ps1
download_url="https://github.com/PowerShellMafia/PowerSploit/raw/master/Privesc/PowerUp.ps1"
file1="PowerUp.ps1"
single_file_check_and_download_file "$download_url" "$file1"


#Downloading Rubeus.exe
download_url="https://github.com/r3motecontrol/Ghostpack-CompiledBinaries/raw/master/Rubeus.exe"
file1="Rubeus.exe"
single_file_check_and_download_file "$download_url" "$file1"


#Downloading Inveigh.exe
# GitHub API URL for the latest release
api_url="https://api.github.com/repos/Kevin-Robertson/Inveigh/releases/latest"
file="https://github.com/Kevin-Robertson/Inveigh/releases/download/.*/Inveigh-net3.5-v[0-9]+\.[0-9]+\.[0-9]+\.zip"
file1="Inveigh.exe"
check_and_download_file "$api_url" "$file" "$file1"


#Downloading Invegih.ps1
download_url="https://github.com/Kevin-Robertson/Inveigh/raw/master/Inveigh.ps1"
file1="Inveigh.ps1"
single_file_check_and_download_file "$download_url" "$file1"


#Downloading Microsoft sysinternal PSTools
download_url="https://download.sysinternals.com/files/PSTools.zip"
file1="PSTools"

# Check if download URL is non-empty
if [[ ! -z "$download_url" ]]; then
    # Check if file exists, if yes, remove it
    if [[ -d "$file1" ]]; then
        rm -r "$file1"
    fi
    # Download the file
    printf "${GREEN}[+] %-15s %s\n" "Downloading:" "$file1"
    wget -q "$download_url" >/dev/null 2>&1
    unzip -q PSTools.zip -d PSTools
    rm PSTools.zip 2>/dev/null
else
    echo -e ${RED}"Failed to download ${YELLOW}$file1${NC}"
fi


#Downloading AutoRecon and installing requrements.
download_url="https://github.com/Tib3rius/AutoRecon.git"
file1="AutoRecon"

# Check if download URL is non-empty
if [[ ! -z "$download_url" ]]; then
    # Check if file exists, if yes, remove it
    if [[ -d "$file1" ]]; then
        rm -r "$file1"
    fi
    # Download the file
    printf "${GREEN}[+] %-15s %s\n" "Downloading:" "$file1"
    git clone "$download_url" >/dev/null 2>&1
    pip install -r AutoRecon/requirements.txt >/dev/null 2>&1
else
    echo -e ${RED}"Failed to download ${YELLOW}$file1${NC}"
fi


#Downloading nc64.exe
download_url="https://github.com/int0x33/nc.exe/raw/master/nc64.exe"
file1="nc64.exe"
single_file_check_and_download_file "$download_url" "$file1"


#Downloading nc.exe
download_url="https://github.com/int0x33/nc.exe/raw/master/nc.exe"
file1="nc.exe"
single_file_check_and_download_file "$download_url" "$file1"


#Downloading PlumHound.py
download_url="https://github.com/PlumHound/PlumHound/raw/master/PlumHound.py"
file1="PlumHound.py"
single_file_check_and_download_file "$download_url" "$file1"


#Downloadning pspy32
# GitHub API URL for the latest release
api_url="https://api.github.com/repos/DominicBreuker/pspy/releases/latest"
file="https://github.com/DominicBreuker/pspy/releases/download/.*/pspy32"
file1="pspy32"
check_and_download_file "$api_url" "$file" "$file1"


#Downloading pspy64
# GitHub API URL for the latest release
api_url="https://api.github.com/repos/DominicBreuker/pspy/releases/latest"
file="https://github.com/DominicBreuker/pspy/releases/download/.*/pspy64"
file1="pspy64"
check_and_download_file "$api_url" "$file" "$file1"


#Downloading Linux Exploit Suggester
download_url="https://github.com/The-Z-Labs/linux-exploit-suggester/raw/master/linux-exploit-suggester.sh"
file1="linux-exploit-suggester.sh"
single_file_check_and_download_file "$download_url" "$file1"


#Downloading Linux PrivChecker
download_url="https://github.com/sleventyeleven/linuxprivchecker/raw/master/linuxprivchecker.py"
file1="linuxprivchecker.py"
single_file_check_and_download_file "$download_url" "$file1"


#Downloading LinEmnum
download_url="https://github.com/rebootuser/LinEnum/raw/master/LinEnum.sh"
file1="LinEnum.sh"
single_file_check_and_download_file "$download_url" "$file1"


#Downloading Kerbrute
# GitHub API URL for the latest release
api_url="https://api.github.com/repos/ropnop/kerbrute/releases/latest"
file="https://github.com/ropnop/kerbrute/releases/download/.*/kerbrute_linux_amd64"
file1="kerbrute_linux_amd64"
check_and_download_file "$api_url" "$file" "$file1"


#Downloading Kerbrute
# GitHub API URL for the latest release
api_url="https://api.github.com/repos/ropnop/kerbrute/releases/latest"
file="https://github.com/ropnop/kerbrute/releases/download/.*/kerbrute_windows_amd64.exe"
file1="kerbrute_windows_amd64.exe"
check_and_download_file "$api_url" "$file" "$file1"


echo -e "${BLUE}[!] ${BLUE}DONE!"${NC}
echo -e ${GREEN}"-----------------------------------------------------"


###################################################################################################################
# Cleanup
###################################################################################################################
unzip mimikatz*.zip >/dev/null 2>&1
cp x64/mimikatz.exe . 2>/dev/null
unzip SharpHound*.zip >/dev/null 2>&1
unzip -qq *.zip 2>/dev/null
rm *.zip *.config *.dll *.pdb *.txt *.chm *.idl *.md *.yar >/dev/null 2>&1
rm -r x64 Win32 >/dev/null 2>&1

cd ${startdir}


###################################################################################################################
# Custom HTTP server from the tools directory
###################################################################################################################

#Adding custom server to server tools to ~/.bashrc
if [[ $(cat ~/.zshrc | grep -o 'servtools()') == 'servtools()' ]]; then
	echo -e "${GREEN}[+]${GREEN} servtools already installed"
	echo -e "${YELLOW}[!] To use this server, reopen terminal and type ${BLUE}servtools <port>"

else
	echo -e "${YELLOW}[!] Adding a custom server for starting HTTP.server form the tools directory"
	echo -e "${YELLOW}[!] Adding servtools to ${user_home}/.zshrc file}"
	echo "" >> ~/.zshrc 2>/dev/null
	echo "" >> ~/.zshrc 2>/dev/null
	echo "" >> ~/.zshrc 2>/dev/null
	echo "" >> ~/.zshrc 2>/dev/null
	echo "# My personal configuration" >> ~/.zshrc 2>/dev/null
	echo "" >> ~/.zshrc 2>/dev/null
	echo "# Http server function which starts an http server from the /tools folder" >> ~/.zshrc 2>/dev/null
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


###################################################################################################################
# Menu Function
###################################################################################################################

# Function to display menu and prompt for user's choice.
menu_choice() {
    echo -e "${GREEN}[?]${BLUE} Choose an option:${NC}"
    echo -e "${GREEN}[1]${YELLOW} Install Tools${NC}"
    echo -e "${GREEN}[2]${YELLOW} Download Scripts${NC}"
    echo -e "${GREEN}[3]${YELLOW} All the above${NC}"
    echo -e "${GREEN}[0]${YELLOW} Exit${NC}"

    read -p "Enter choice [1-3]: [0] To Exit: " choice

    case $choice in
        1) install_tools ;;
        2) download_scripts ;;
        3) 
            install_tools
            download_scripts
            ;;
        0) 
            echo -e "${GREEN}[+] Exiting...${NC}"
            exit 0
            ;;
        *) 
            echo -e "${RED}[!] Invalid option. Please choose a number between 0-3.${NC}"
            menu_choice
            ;;
    esac
}

menu_choice
