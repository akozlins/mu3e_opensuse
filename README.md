#

- download and install OpenSuse Leap 15.3
    - select "Activate Online Repositories"
    - select "Desktop with GNOME"
    - partitioning:
        - select "Guided Setup"
        - `ext4` file system, no swap partition
    - clock and time zone: Europe / Germany
    - user: `labor`, password: `labor`
        - do not "Use this password for root user" and set standard root password
    - installation settings: enable ssh, open ssh port
- packages:
    - `sudo zypper install git make`
    - `git clone https://github.com/akozlins/mu3e_opensuse`
