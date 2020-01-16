#!/bin/bash

clear
echo "#####################"
echo "# Kali Setup Script #"
echo "#####################"
echo ""
echo ""
echo "[*] Before starting, make sure that..."
echo "      1. You've setup VBox Tools/VMWare tools if running in a VM"
echo "      2. You're running as root, either by login or sudo"
read -p "Press any key to continue with setup..."

if [[ $(id -u) != 0 ]]; then
	echo -e "\n[!] Setup script needs to run as root!\n\n"
	exit 0
fi

echo -e "\n\n"
echo "[*] Updating and upgrading system before starting..."
apt update -y
apt full-upgrade -y

echo -e "\n\n"
echo "[*] Installing pre-reqs..."
apt install -y git ansible python-pip python3-pip golang-go python-dnspython libpcap-dev libssl-dev libnetfilter-queue-dev
pip install ldap3

echo -e "\n\n"
echo "[*] Cloning and installing the BrashEndeavours/hotwax repo..."
cd ~
git clone https://github.com/BrashEndeavours/hotwax .hotwax
cd .hotwax
mv tasks/install_custom_samba.yml tasks/install_custom_samba.old
cp ~/kali-setup/install_custom_samba.yml tasks/install_custom_samba.yml
ansible-playbook playbook.yml

echo -e "\n\n"
echo "[*] Cloning and setting up the m8r0wn/nullinux repo..."
cd /opt
git clone https://github.com/m8r0wn/nullinux
cd nullinux
bash setup.sh

echo -e "\n\n"
echo "[*] Cloning and setting up the maurosoria/dirsearch repo, and creating alias..."
cd /opt
git clone https://github.com/maurosoria/dirsearch.git
echo "alias dirsearch='python3 /opt/dirsearch/dirsearch.py'" >> ~/.bash_aliases

echo -e "\n\n"
echo "[*] Cloning and setting up guelfoweb/knock repo and alias..."
cd /opt
git clone https://github.com/guelfoweb/knock.git
cd knock
python setup.py install
#echo "alias knockpy='python /opt/knock/knockpy/knockpy.py'" >> ~/.bash_aliases

echo -e "\n\n"
echo "[*] Cloning and setting alias for repo..."
cd /opt
git clone https://github.com/aboul3la/Sublist3r.git sublister
cd sublister
pip install -r requirements.txt
echo "alias sublister='python /opt/sublister/sublist3r.py'" >> ~/.bash_aliases

echo -e "\n\n"
echo "[*] Cloning and setting up vanhauser-thc/thc-ipv6 repo and setting aliases..."
cd /opt
git clone https://github.com/vanhauser-thc/thc-ipv6.git
cd thc-ipv6
make install
#TODO: Aliases for thc-ipv6 tools

echo -e "\n\n"
echo "[*] Setting up kerbrute and windapsearch, and setting aliases..."
cd /opt
mkdir kerbrute
cd kerbrute
wget https://github.com/ropnop/kerbrute/releases/download/v1.0.3/kerbrute_linux_amd64
echo "alias kerbrute='/opt/kerbrute/kerbrute_linux_amd64'" >> ~/.bash_aliases
cd /opt
git clone https://github.com/ropnop/windapsearch.git
echo "alias windapsearch='python3 /opt/windapsearch/windapsearch.py'" >> ~/.bash_aliases

echo -e "\n\n"
echo "[*] Cloning 3ndG4me/AutoBlue-MS17-010 repo and setting nav alias..."
cd /opt
git clone https://github.com/3ndG4me/AutoBlue-MS17-010.git autoblue
echo "alias goblue='cd /opt/autoblue'" >> ~/.bash_aliases

echo -e "\n\n"
echo "[*] Extracting rockyou and grabbing some more wordlists..."
cd /usr/share/wordlists
gunzip -d /usr/share/wordlists/rockyou.txt.gz
wget -nc http://www.tekdefense.com/downloads/wordlists/1aNormusWL.zip
wget -nc http://www.tekdefense.com/downloads/wordlists/KippoWordlist.txt
unzip 1aNormusWL.zip
rm 1aNormusWL.zip

echo -e "\n\n"
echo "[*] Setting up common aliases..."
echo "alias updateme='apt update&&apt list --upgradeable'" >> ~/.bash_aliases
echo "alias upgrademe='apt full-upgrade -y'" >> ~/.bash_aliases
echo "alias sspt='searchsploit'" >> ~/.bash_aliases

echo -e "\n\n"
echo "[*] All done!"
exit 0








