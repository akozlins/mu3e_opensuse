#

- download and install OpenSuse Leap 15.5
    - select "Activate Online Repositories"
    - select "Desktop with GNOME"
    - partitioning:
        - select "Guided Setup"
        - choose "Remove even if not needed" everywhere
        - `ext4` file system, no swap partition
    - clock and time zone: Europe / Germany
    - user: `labor`, password: `labor`
        - do not "Use this password for root user" and set standard root password
    - installation settings: enable ssh, open ssh port
- packages:
    - `sudo zypper install git make`
    - `git clone https://github.com/akozlins/mu3e_opensuse`
    - `cd mu3e_opensuse` and `make init`
    - geant4: `make geant4-make` and `make geant4-install`
    - root: `make room-make` and `make root-install`
    - midas: `make midas-make` and `make midas-install`

## setup

- `sudo systemctl link /usr/share/systemd/tmp.mount`
- `sudo ln -fs /dev/null /etc/sysctl.d/50-coredump.conf`

```
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-13 130
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-13 130
sudo update-alternatives --config g++
sudo update-alternatives --config gcc
```

### forwarding

- `sudo yast routing ip-forwarding on`
- 'systemsettings' -> enable `firewalld`
- `eth0` -> external network, `eth1` -> internal network

## release upgrade

```
sudo zypper repos --uri
sudo zypper --releasever=15.5 lr -u
sudo zypper --releasever=15.5 refresh
sudo zypper --releasever=15.5 dup --download-in-heaps
```

## vscode

- <https://en.opensuse.org/Visual_Studio_Code>

```
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo zypper addrepo https://packages.microsoft.com/yumrepos/vscode vscode
sudo zypper refresh
sudo zypper install code
```

## cuda

```
sudo zypper addrepo https://developer.download.nvidia.com/compute/cuda/repos/opensuse15/x86_64/cuda-opensuse15.repo
sudo zypper install cuda-12-4
sudo usermod -a -G video mu3e
```

## quartus

```
https://github.com/superzeldalink/quartus-install
cd quartus-install
sudo zypper in aria2
./quartus-install.py --download-only 20.1std . a10 a5 m10 m5
sudo ./quartus-install.py --install-only 20.1std /opt/intelFPGA/20.1 a10 a5 m10 m5
```
