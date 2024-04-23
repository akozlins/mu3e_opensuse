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
