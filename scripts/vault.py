#!/usr/bin/env python
import os
from pathlib import PosixPath
from typing import List
from subprocess import run, PIPE

this_file = os.path.realpath(__file__)


def sudo_user() -> str:
    return os.getenv('SUDO_USER')


def get_password() -> str:
    cmd = 'bw get password Ansible'
    return run(cmd.split(), stdout=PIPE).stdout.decode('utf-8').strip()


def encrypt(file: PosixPath, output_file: str = None) -> None:
    cmd = f'ansible-vault encrypt --vault-id {this_file}'
    if output_file:
        cmd += f' --output {output_file}'
    cmd += ' ' + str(file.absolute())

    run(cmd.split())


if __name__ == '__main__':
    print(get_password())
