#!/usr/bin/env python
import shutil
from pathlib import Path

import vault


sudo_user = vault.sudo_user()
if not sudo_user:
    print('This script must be run with root privileges')
    exit(1)

initial_user_home = Path(f'/home/{vault.sudo_user()}')
connections = Path('/etc/NetworkManager/system-connections')
encrypted_con_path = initial_user_home/'setup'/'roles'/'networkmanager'/'files'

files = []
for connection in connections.glob('*'):
    dst = shutil.copy(connection, encrypted_con_path)
    files.append(dst)

vault.encrypt(files)
for file in files:
    shutil.chown(file, sudo_user, sudo_user)
