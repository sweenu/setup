# Defined in - @ line 0
function pipup --description alias\ pipup\ pip\ list\ --outdated\ --format=freeze\ \|\ grep\ -v\ \'\^\\-e\'\ \|\ cut\ -d\ =\ -f\ 1\ \ \|\ xargs\ -n1\ sudo\ pip\ install\ -U
	pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 sudo pip install -U $argv;
end
