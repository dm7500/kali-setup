# kali-setup script

A quick script I made to get a new Kali VM (or machine) configured with all my preferred tools and aliases.

## Setup and running
```shell
git clone https://github.com/dm7500/kali-setup
cd kali-setup
chmod +x setup_kali.sh
./setup_kali.sh
```

## Tools installed:

- [hotwax](https://github.com/BrashEndeavours/hotwax)
- [nullinux](https://github.com/m8r0wn/nullinux)
- [dirsearch](https://github.com/maurosoria/dirsearch)
- [knock](https://github.com/guelfoweb/knock)
- [Sublist3r](https://github.com/aboul3la/Sublist3r)
- [thc-ipv6](https://github.com/vanhauser-thc/thc-ipv6)
- [kerbrute](https://github.com/ropnop/kerbrute)
- [windapsearch](https://github.com/ropnop/windapsearch)
- [AutoBlue-MS17-010](https://github.com/3ndG4me/AutoBlue-MS17-010)

## Aliases set:
- `sspt='searchsploit'`
- `updateme='apt update&&apt list --upgradeable'`
- `upgrademe='apt full-upgrade -y'`
- `goblue='cd /opt/autoblue'`
- `windapsearch='python3 /opt/windapsearch/windapsearch.py'`
- `kerbrute='/opt/kerbrute/kerbrute_linux_amd64'`
- `sublister='python /opt/sublister/sublist3r.py'`
- `dirsearch='python3 /opt/dirsearch/dirsearch.py'`