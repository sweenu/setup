- Ansible:
  - arch-install: look into activating TRIM with cryptsetup for SSDs
  - arch-install: complete wipe_disk task by adding SATA SSDs and HDDs
  - arch-install: make the output of 'arch-chroot ansible-playbook' better. And the status change according to it's status
  - find another way for setting facts than in pre_tasks because it does not work well with --start-at-task
  - rclone: find a way to add google drive remote without a graphical browse and then uncommend openlp's use of rclone and gdrive task itself
  - mkinitcpio and lightdm-plymouth should only be used if actually using plymouth
  - networkmanager: potentially use nmcli module instead of what I do
  - format: make some research on the error of vfat on logical sector size of 4MiB and change format role accordingly
  - wipe: see why nvme format --ses 2 does sometime not work and print a prompt to know if user wanna continue with zero filling disk instead
  - prompt to reboot at the end of install play

- Qtile:
  - format code (possibly with black?)
  - Notifications for battery level

- Other:
  - make booting and shutting down completely silent
  - setup control of external monitor through keyboard
  - after reinstall, check this: https://wiki.archlinux.org/index.php/Btrfs#Checksum_hardware_acceleration
