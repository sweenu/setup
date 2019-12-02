# Starship prompt https://github.com/starship/starship
eval (starship init fish)

status --is-interactive; and pyenv init - | source
status --is-interactive; and pyenv virtualenv-init - | source

for dir in (basename ~/Repos/devcker/projects/*)
  function $dir -V dir
    echo
    cd ~/Repos/devcker/projects/$dir
  end
end
