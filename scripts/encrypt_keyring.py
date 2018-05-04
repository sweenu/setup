#!/usr/bin/env python
import os
import shutil
from pathlib import Path

import vault

encrypted_files_path = Path.home()/'setup'/'roles'/'gnome-keyring'/'files'
data_home = os.getenv('XDG_DATA_HOME')
if not data_home:
    print('XDG_DATA_HOME is not set')
    exit(1)

files = []
for file in Path(f'{data_home}/keyrings').glob('*'):
    dst = shutil.copy(file, encrypted_files_path)
    files.append(dst)

vault.encrypt(files)
