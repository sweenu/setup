function mdown
    pandoc $argv | lynx -stdin
end
