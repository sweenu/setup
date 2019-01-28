function aps --description 'alias aps ansible-playbook <playbook_dir>/site.yml --vault-id <playbook_dir>/scripts/vault.sh'
  ansible-playbook ~/setup/site.yml --vault-id ~/setup/scripts/vault.py --diff $argv;
end
