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

### forwarding

- `sudo yast routing ip-forwarding on`
- 'systemsettings' -> enable `firewalld`
- `eth0` -> external network, `eth1` -> trusted network

## upgrade

```
sudo zypper repos --uri
# NOTE: updgrade must be done to next version (e.g. 15.5 -> 15.6)
sudo zypper --releasever=15.6 lr -u
sudo zypper --releasever=15.6 refresh
sudo zypper --releasever=15.6 dup --download-in-advance
sudo zypper rm --clean-deps $(zypper packages --orphaned --unneeded | awk -F'|' '{if($1~"^i ") print $3}')

sudo zypper addrepo https://developer.download.nvidia.com/compute/cuda/repos/opensuse15/x86_64/cuda-opensuse15.repo
sudo usermod -a -G video "$USER"

# remove nvidia drivers and cleanup
sudo zypper remove '*nvidia*' 'cuda-*' cuda
# install nvidia drivers
sudo zypper refresh
sudo zypper in nvidia-open-driver-G06-signed-cuda-kmp-default
nvidia_version=$(rpm -qa --queryformat '%{VERSION}\n' nvidia-open-driver-G06-signed-cuda-kmp-default | cut -d "_" -f1 | sort -u | tail -n 1)
sudo zypper in "nvidia-compute-utils-G06==${nvidia_version}" "nvidia-persistenced==${nvidia_version}" "nvidia-video-G06==${nvidia_version}"
sudo zypper in cuda-toolkit-13
# check versions
zypper search --details --installed-only nvidia

sudo zypper addrepo https://download.opensuse.org/repositories/electronics/15.6 electronics
sudo zypper in ghdl gtkwave

sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
```

## opensuse 16

```
# upgrade from 15.6 to 16
sudo zypper in opensuse-migration-tool

# ia32
sudo zypper in grub2-compat-ia32 libXft2-32bit libgcc_s1-32bit
sudo /usr/sbin/update-bootloader --add-option "ia32_emulation=1"
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

## vscode

- <https://en.opensuse.org/Visual_Studio_Code>

```
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo zypper addrepo https://packages.microsoft.com/yumrepos/vscode vscode
sudo zypper refresh
sudo zypper install code
```

## firewall configuration

run `sudo yast` and in 'Security and Users' -> 'Firewall' do following:

- in 'Interfaces' change external (PSI network interface, usually `eth0`) interface type to 'external'
  and change internal (e.g. `eth3`) interface to 'trusted'
- in 'Zones' set external interface as 'Default'
- in 'Start-Up' request 'Restart' of firewall service
- save configuration
- on one of the internal machines (e.g. `mu3efarm0`) check connection to outside with `ping google.com`
