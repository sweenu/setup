function fish_title
    if [ $_ =  'fish' ]
        echo (prompt_pwd)
    else
        echo $argv[1]
    end
end
