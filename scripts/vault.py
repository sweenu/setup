#!/usr/bin/env python
import os
from typing import List
from subprocess import run, PIPE

this_file = os.path.realpath(__file__)


def sudo_user() -> str:
    return os.getenv('SUDO_USER')


def get_initial_user() -> str:
    return os.getenv('USER') if not sudo_user() else os.getenv('SUDO_USER')


def get_password() -> str:
    cmd = f'sudo -u {get_initial_user()} secret-tool lookup ansible-vault myvault'
    return run(cmd.split(), stdout=PIPE).stdout.decode('utf-8')


def encrypt(files: List[str], output_file: str = None) -> None:
    cmd = f'ansible-vault encrypt --vault-id {this_file}'
    if output_file:
        cmd += f' --output {output_file}'
    cmd += ' ' + ' '.join(files)

    run(cmd.split())


if __name__ == '__main__':
    print(get_password())
