# cryptmypi - Drop Pi Edition

Most of the code was pulled from: https://github.com/unixabg/cryptmypi

Assists in the full setup of [encrypted] Raspberry Pis for the nac bypass drop-pi (https://github.com/ditmer/Drop-Pi). Able to maintain multiple setup configurations, for multiple usages, offers a multitude of modular configurations hooks providing out-of-the-box optional features for initramfs (while the system in encrypted) and the actual system (after boot).

Decryption is done via USB key. The USB can be removed after boot, ensuring the drop-pi remains encrypted if stolen by bad people

## How it works

A configuration profile defines 2 stages:

1. A base OS image is extracted.
2. The build is written to an SD card.

Optional configuration hooks can be set in any of the stages:
- Configurations applyed on stage 1 will be avaiable to the stage 2. Each time the script runs it will check if a stage 1 build is already present, and will ask if it should be used or if it should be rebuilt.
- Stage 2 can be executed as many times as wanted without affecting stage's 1 build. Every configuration applyed in stage 2 will be applyed directly to the SD card.

## Capabilities

1. **FULL DISK ENCRYPTION**: Although the project can be used to setup an unencrypted RPi box, it is currently capable to setup a fully encrypted Kali, Pi OS, or Ubuntu Linux.

- unlockable remotely through dropbear's ssh;
- served through ethernet or wifi;
- exposed to the internet using reverse forwarding: sshhub.de (or custom ssh server) as a jumphost;
- bypass firewalls using IODINE;
- and a nuke password can be set;

2. **OPERATIONAL**: System optional hooks can assist in many commonly configurations.

- Drop-Pi Install;
- system DNS server configuration;
- changing the root password;
- Add standard user
- ssh service, with authorized_keys;

## Installation

Clone this git repo.

## Usage

Simply:

$ `./cryptmypi.sh configuration_profile_directory`

`configuration_profile_directory` should be an existing configuration directory. Use one of the provided examples or create your own.

## USB Decryption

The encrypted SD Card is decrypted via a USB key or password (if needed). This USB key can be removed once the Pi has booted.

In order for this to work, you need to do a little work:

1. Create a key on the USB device:

    ```bash
    # Use this exact command - if you change the BS or Count, it must match in the decrypt with key script in 3000-stage1-setup-encryption.hook on line 91

    sudo dd bs=32 count=1 if=/dev/random of=dec.key
    
    ```
2. Get full path of mounted USB Key - like /media/whatever/9ecfba84-47d4-4495-a7db-418fdce15cad
3. Get UUID of USB Drive. Use the UUID not PARTUUID:

    ```bash
    sudo blkid

    [...]

    /dev/sda2: UUID="9ecfba84-47d4-4495-a7db-418fdce15cad" BLOCK_SIZE="4096" TYPE="ext4"  #USB /dev/sda2 mounted at /media/whatever 
    [...]
    ```

4. Add this information to the relevant variables in the cryptmypi.conf for the config template you want to use - config/ubuntu-encrypted-basic/cryptmypi.conf