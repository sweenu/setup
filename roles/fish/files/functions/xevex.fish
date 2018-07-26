# Defined in - @ line 0
function xevex --description 'A more concise output to xev'
	command xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }';
end
