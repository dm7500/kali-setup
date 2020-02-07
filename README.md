# kali-setup script

A quick script I made to get a new Kali VM (or machine) configured with all my preferred tools and aliases.

## Setup and running
```shell
git clone https://github.com/dm7500/kali-setup
cd kali-setup
chmod +x setup_kali.sh
sudo ./setup_kali.sh #sudo is needed from versions > 2019.4 
```

## Tools installed:
- [hotwax](https://github.com/BrashEndeavours/hotwax)
  - Arjun
  - AutoRecon
  - BloodHound
  - chisel
  - evil-winrm
  - gobuster
  - LinEnum
  - nishang
  - One-Lin3r
  - OSCP Exam Report Template
  - Powerless
  - PowerSploit
  - proxychains-ng
  - pspy
  - SecLists
  - sherlock
  - sshuttle
  - webshell
  - Windows PHP Reverse Shell
  - XSStrike
  - zauberfeder
  - Fixes borked Kali install of Samba
  - Re-installs enum4linux to work with fixed Samba install
- [nullinux](https://github.com/m8r0wn/nullinux)
- [dirsearch](https://github.com/maurosoria/dirsearch)
- [linux-smart-enumeration](https://github.com/diego-treitos/linux-smart-enumeration)
- [knock](https://github.com/guelfoweb/knock)
- [Sublist3r](https://github.com/aboul3la/Sublist3r)
- [thc-ipv6](https://github.com/vanhauser-thc/thc-ipv6)
- [kerbrute](https://github.com/ropnop/kerbrute)
- [windapsearch](https://github.com/ropnop/windapsearch)
- [AutoBlue-MS17-010](https://github.com/3ndG4me/AutoBlue-MS17-010)
- [spiderfoot](https://github.com/smicallef/spiderfoot.git)
- [tnscmd10g](https://tools.kali.org/vulnerability-analysis/tnscmd10g)
- [OScanner](http://www.cqure.net/wp/tools/database/oscanner/)
- [flameshot](https://flameshot.js.org/#/)
- [kate](https://kate-editor.org/)
- Firefox ESR

## Aliases set:
- `sspt='searchsploit'`
- `updateme='sudo apt update&&apt list --upgradeable'`
- `upgrademe='sudo apt full-upgrade -y'`
- `goblue='cd /opt/autoblue'`
- `windapsearch='python3 /opt/windapsearch/windapsearch.py'`
- `kerbrute='/opt/kerbrute/kerbrute_linux_amd64'`
- `sublister='python /opt/sublister/sublist3r.py'`
- `dirsearch='python3 /opt/dirsearch/dirsearch.py'`
- `sfscan='python3 /opt/spiderfoot/sf.py`
- `sfweb='python3 /opt/spiderfoot/sf.py -l 127.0.0.1'`

## Misc items:
- Unzips existing `rockyou.txt` file
- Downloads and extracts `1aNormusWL` and `KippoWordlist` wordlists
- Request name of user, and assigns them as owner of all items in `/opt`
- Adds specified user to `vboxsf` group, for proper access to Vbox shared folders.
- Installs VS Code from `.deb` file.