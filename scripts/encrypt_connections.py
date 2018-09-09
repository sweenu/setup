#!/usr/bin/env python
import shutil
import tarfile
from pathlib import Path

import vault


sudo_user = vault.sudo_user()
if not sudo_user:
    print('This script must be run with root privileges')
    exit(1)

connections = Path('/etc/NetworkManager/system-connections')
setup_dir = Path(__file__).parent.parent
tarfile_path = setup_dir / 'roles' / 'networkmanager' / 'files' / 'connections.tar.gz'

with tarfile.open(tarfile_path, 'w:gz') as tar:
    for connection in connections.glob('*'):
        tar.add(connection, arcname=connection.name)

vault.encrypt([str(tarfile_path)])
