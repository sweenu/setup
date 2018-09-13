# Defined in - @ line 0
function bwu --description 'alias bwu set -Ux BW_SESSION (bw unlock --raw)'
	set -Ux BW_SESSION (bw unlock --raw) $argv;
end
