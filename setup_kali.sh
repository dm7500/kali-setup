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

echo "[*] Please provide the username of the owner of this VM..."
read -p 'Username: ' username

echo -e "\n\n"
echo "[*] Updating and upgrading system before starting..."
apt update -y
apt full-upgrade -y

echo -e "\n\n"
echo "[*] Installing pre-reqs..."
apt install -y git ansible python-pip python3-pip golang-go python-dnspython libpcap-dev libssl-dev libnetfilter-queue-dev
pip install ldap3

echo -e "\n\n"
echo "[*] Installing tools from Kali repos..."
apt install oscanner tnscmd10g flameshot kate firefox-esr ark powershell

echo -e "\n\n"
echo "[*] Cloning and installing the BrashEndeavours/hotwax repo..."
cd /home/$username
git clone https://github.com/BrashEndeavours/hotwax .hotwax
cd .hotwax
# Fixes issue with python-gnupg install in hotwax #
mv tasks/install_custom_samba.yml tasks/install_custom_samba.old
cp /home/$username/kali-setup/install_custom_samba.yml tasks/install_custom_samba.yml
#
ansible-playbook playbook.yml

echo -e "\n\n"
echo "[*] Cloning and setting up the m8r0wn/nullinux repo..."
cd /opt
git clone https://github.com/m8r0wn/nullinux
cd nullinux
bash setup.sh

echo -e "\n\n"
cd /opt
echo "[*] Cloning the diego-treitos/linux-smart-enumeration repo..."
git clone https://github.com/diego-treitos/linux-smart-enumeration.git lse

echo -e "\n\n"
echo "[*] Cloning and setting up the maurosoria/dirsearch repo, and creating alias..."
cd /opt
git clone https://github.com/maurosoria/dirsearch.git
echo "alias dirsearch='python3 /opt/dirsearch/dirsearch.py'" >> /home/$username/.bash_aliases

echo -e "\n\n"
echo "[*] Cloning and setting up guelfoweb/knock repo..."
cd /opt
git clone https://github.com/guelfoweb/knock.git
cd knock
python setup.py install

echo -e "\n\n"
echo "[*] Cloning and setting alias for aboul3la/Sublist3r repo..."
cd /opt
git clone https://github.com/aboul3la/Sublist3r.git sublister
cd sublister
pip install -r requirements.txt
echo "alias sublister='python /opt/sublister/sublist3r.py'" >> /home/$username/.bash_aliases

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
echo "alias kerbrute='/opt/kerbrute/kerbrute_linux_amd64'" >> /home/$username/.bash_aliases
cd /opt
git clone https://github.com/ropnop/windapsearch.git
echo "alias windapsearch='python3 /opt/windapsearch/windapsearch.py'" >> /home/$username/.bash_aliases

echo -e "\n\n"
echo "[*] Cloning 3ndG4me/AutoBlue-MS17-010 repo and setting nav alias..."
cd /opt
git clone https://github.com/3ndG4me/AutoBlue-MS17-010.git autoblue
echo "alias goblue='cd /opt/autoblue'" >> /home/$username/.bash_aliases

echo -e "\n\n"
echo "[*] Cloning the smicallef/spiderfoot repo and setting alias..."
cd /opt
git clone https://github.com/smicallef/spiderfoot.git
cd spiderfoot
pip3 install -r requirements.txt
echo "alias sfweb='python3 /opt/spiderfoot/sf.py -l 127.0.0.1'" >> /home/$username/.bash_aliases
echo "alias sfscan='python3 /opt/spiderfoot/sf.py'" >> /home/$username/.bash_aliases

echo -e "\n\n"
echo "[*] Cloning the immunIT/drupwn repo..."
cd /opt
git clone https://github.com/immunIT/drupwn.git
cd drupwn
python3 setup.py install
pip3 install 'prompt_toolkit<=2.0.7'

echo -e "\n\n"
echo "[*] Installing updog with pip3..."
pip3 install updog

echo -e "\n\n"
echo "[*] Extracting rockyou and grabbing some more wordlists..."
cd /usr/share/wordlists
gunzip -d /usr/share/wordlists/rockyou.txt.gz
wget -nc http://www.tekdefense.com/downloads/wordlists/1aNormusWL.zip
wget -nc http://www.tekdefense.com/downloads/wordlists/KippoWordlist.txt
unzip 1aNormusWL.zip
rm 1aNormusWL.zip

echo -e "\n\n"
echo "[*] Grabbing and installing VS Code..."
cd /home/$username/Downloads
wget https://go.microsoft.com/fwlink/?LinkID=760868 -O code_install.deb
dpkg -i code_install.deb

echo -e "\n\n"
echo "[*] Setting ownership of /opt folder for GitHub repos..."
chown -hR $username:$username /opt

echo -e "\n\n"
echo "[*] Setting user as member of vboxsf, for access to Vbox shared folder..."
adduser $username vboxsf
echo "[!] User $username added to vboxsf group. You will have to reboot the system after the script runs, for this to take effect."
read -p "Press any key to continue..."

echo -e "\n\n"
echo "[*] Setting up common aliases..."
echo "alias updateme='sudo apt update&&apt list --upgradeable'" >> /home/$username/.bash_aliases
echo "alias upgrademe='sudo apt full-upgrade -y'" >> /home/$username/.bash_aliases
echo "alias sspt='searchsploit'" >> /home/$username/.bash_aliases
echo "alias arjun='python3 /opt/arjun/arjun.py'" >> /home/$username/.bash_aliases
echo "alias autorecon='python3 /opt/autorecon/autorecon.py'" >> /home/$username/.bash_aliases
echo "alias evil-winrm='ruby /opt/evil-winrm/evil-winrm.rb'" >> /home/$username/.bash_aliases
echo "alias sherlock='python3 /opt/sherlock/sherlock.py'" >> /home/$username/.bash_aliases
echo "alias xsstrike='python3 /opt/xsstrike/xsstrike.py'" >> /home/$username/.bash_aliases

echo -e "\n\n"
echo "[*] Adding symlinks for wordlists and seclists folders to home directory..."
cd /home/$username
ln -s /usr/share/wordlists wordlists
ln -s /usr/share/seclists seclists

echo -e "\n\n"
echo "[*] All done! Be sure to reboot the VM before using."
exit 0








