#!/bin/bash

RED='\033[0;31m' #Red color
ORA='\033[0;33m' #Red color
NC='\033[0m' # No color

clear
echo "${ORA}#####################${NC}"
echo "${ORA}# Kali Setup Script #${NC}"
echo "${ORA}#####################${NC}"
echo ""
echo ""
echo "${ORA}[*] Before starting, make sure that...${NC}"
echo "      1. You've setup VBox Tools/VMWare tools if running in a VM"
echo "      2. You're running as root, either by login or sudo"
read -p "Press any key to continue with setup..."

if [[ $(id -u) != 0 ]]; then
	echo -e "\n${RED}[!] Setup script needs to run as root!\n\n${NC}"
	exit 0
fi

echo "${ORA}[*] Updating and upgrading system before starting...${NC}"
apt update -y
apt full-upgrade -y

echo "${ORA}[*] Installing pre-reqs...${NC}"
apt install -y git ansible python-pip python3-pip python-ldap golang-go python-dnspython libpcap-dev libssl-dev libnetfilter-queue-dev
pip install ldap3

echo "${ORA}[*] Cloning and installing the BrashEndeavours/hotwax repo...${NC}"
cd ~
git clone https://github.com/BrashEndeavours/hotwax .hotwax
cd .hotwax
mv tasks/install_custom_sabma.yml tasks/install_custom_samba.old
script_dir=dirname "$0"
cp $script_dir/install_custom_sabma.yml tasks/install_custom_sabma.yml
ansible-playbook playbook.yml

echo "${ORA}[*] Cloning and setting up the m8r0wn/nullinux repo...${NC}"
cd /opt
git clone https://github.com/m8r0wn/nullinux
cd nullinux
bash setup.sh

echo "${ORA}[*] Cloning and setting up the maurosoria/dirsearch repo, and creating alias...${NC}"
cd /opt
git clone https://github.com/maurosoria/dirsearch.git
echo "alias dirsearch='python3 /opt/dirsearch/dirsearch.py'" >> ~/.bash_aliases

echo "${ORA}[*] Cloning and setting up guelfoweb/knock repo and alias...${NC}"
cd /opt
git clone https://github.com/guelfoweb/knock.git
cd knock
python setup.py install
echo "alias knockpy='python /opt/knock/knockpy/knockpy.py'" >> ~/.bash_aliases

echo "${ORA}[*] Cloning and setting alias for repo...${NC}"
cd /opt
git clone https://github.com/aboul3la/Sublist3r.git sublister
cd sublister
pip install -r requirements.txt
echo "alias sublister='python /opt/sublister/sublist3r.py'" >> ~/.bash_aliases

echo "${ORA}[*] Cloning and setting up vanhauser-thc/thc-ipv6 repo and setting aliases...${NC}"
cd /opt
git clone https://github.com/vanhauser-thc/thc-ipv6.git
cd thc-ipv6
make install
#TODO: Aliases for thc-ipv6 tools

echo "${ORA}[*] Setting up kerbrute and windapsearch, and setting aliases...${NC}"
cd /opt
mkdir kerbrute
cd kerbrute
wget https://github.com/ropnop/kerbrute/releases/download/v1.0.3/kerbrute_linux_amd64
echo "alias kerbrute='/opt/kerbrute/kerbrute_linux_amd64'" >> ~/.bash_aliases
cd /opt
git clone https://github.com/ropnop/windapsearch.git
echo "alias windapsearch='python3 /opt/windapsearch/windapsearch.py'" >> ~/.bash_aliases

echo "${ORA}[*] Cloning 3ndG4me/AutoBlue-MS17-010 repo and setting nav alias...${NC}"
cd /opt
git clone https://github.com/3ndG4me/AutoBlue-MS17-010.git autoblue
echo "alias goblue='cd /opt/autoblue'" >> ~/.bash_aliases

echo "${ORA}[*] Extracting rockyou and grabbing some more wordlists...${NC}"
cd /usr/share/wordlists
gunzip -d /usr/share/wordlists/rockyou.txt.gz
wget -nc http://www.tekdefense.com/downloads/wordlists/1aNormusWL.zip
wget -nc http://www.tekdefense.com/downloads/wordlists/KippoWordlist.txt
unzip 1aNormusWL.zip
rm 1aNormusWL.zip

echo "${ORA}[*] Setting up common aliases...${NC}"
echo "alias updateme='apt update&&apt list --upgradeable'" >> ~/.bash_aliases
echo "alias upgrademe='apt full-upgrade -y'" >> ~/.bash_aliases
echo "alias sspt='searchsploit'" >> ~/.bash_aliases

echo "${ORA}[*] All done!${NC}"
exit 0








