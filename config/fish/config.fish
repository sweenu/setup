if not set -q DISPLAY; and [ (tty) = /dev/tty1 ]
    exec startx
end

set -gx PATH $PATH /home/sweenu/nand2tetris/tools

set -g theme_display_virtualenv yes
