function aps --description 'alias aps ansible-playbook --vault-id (bw get password ansible | psub) --diff $argv'
  ansible-playbook --vault-id (bw get password ansible | psub) --diff $argv;
end
