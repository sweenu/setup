- Ansible:
  - arch-install: look into activating TRIM with cryptsetup for SSDs
  - arch-install: complete wipe_disk task by adding SATA SSDs and HDDs
  - arch-install: make the output of 'arch-chroot ansible-playbook' better. And the status change according to it's status
  - find another way for setting facts than in pre_tasks because it does not work well with --start-at-task
  - rclone: find a way to add google drive remote without a graphical browse
  - mkinitcpio and lightdm-plymouth should only be used if actually using plymouth
  - networkmanager: potentially use nmcli module instead of what I do

- Qtile:
  - format code (possibly with black?)
  - Notifications for battery level

- Other:
  - make booting and shutting down completely silent
  - setup control of external monitor through keyboard
  - after reinstall, check this: https://wiki.archlinux.org/index.php/Btrfs#Checksum_hardware_acceleration
