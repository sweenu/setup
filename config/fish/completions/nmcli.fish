function __no_subcommand --description 'Test if nmcli has yet to be given the subcommand'
    for i in (commandline -opc)
        if [ $i = 'nmcli' ]
            continue
        end
        if contains (string sub -l 1 -- $i) h g n r c d a m
            return 1
        end
    end
    return 0
end

function __are_last_subcommands --description 'Test if the (count $argv) last commands are $argv'
    set -l cmd (commandline -opc)
    set -l nb_args (count $argv)
    if [ $nb_args -gt (count $cmd) ]
        return 1
    else
        for i in (seq $nb_args)
            set -l first_letter_cmd (string sub -l 1 -- $argv[$i])
            set -l first_letter_subcmd (string sub -l 1  -- $cmd[(math -$nb_args - 1 + $i)])
            if [ $first_letter_cmd != $first_letter_subcmd ]
                return 1
            end
        end
    end
    return 0
end

function __print_wifi_ssid -d 'Print a list of available wifi SSIDs with their signal strength seperated by semicolons'
    nmcli --terse device wifi | cut -d : -f 2,6
end

function __print_fields -d 'Print available fields for the current command'
    switch $argv
    case wifi
        echo 'name ssid ssid-hex bssid mode chan freq signal bars security wpa-flags rsn-flags device active in-use dbus-path'
    end
end

function __complete_wifi_connect -d 'Completions for nmcli device wifi connect'
    for wifi in (__print_wifi_ssid)
        set -l ssid (echo $wifi | cut -d : -f 1)
        set -l rate (echo $wifi | cut -d : -f 2)
        complete -c nmcli -n '__are_last_subcommands wifi connect' -a $ssid -d $rate
    end
end

complete -fc nmcli

## Common options
complete -c nmcli -s t -l terse -d 'Output is terse'
complete -xc nmcli -s m -l mode -a 'tabular multiline' -d 'Switch between tabular and multiline output'
complete -xc nmcli -s c -l colors -a 'yes no auto' -d 'Controls color output'
complete -xc nmcli -s f -l fields -a 'all common' -d 'Specify fields to be printed'
complete -xc nmcli -s g -l get-values -a 'all common' -d 'Shortcut for -m tabular -t -f'
complete -xc nmcli -s e -l escape -a 'yes no' -d 'Whether to escape : and \ with \ '
complete -c nmcli -s a -l ask -d 'Interactively ask for missing arguments'
complete -c nmcli -s s -l show-secrets -d 'Display passwords and secrets'
complete -c nmcli -s w -l wait -d 'Sets a timeout period to finish operation'
complete -c nmcli -s v -l version -d 'Show nmcli version'
complete -c nmcli -s h -l help -d 'Print help information'

## Subcommands
# help
complete -c nmcli -n '__no_subcommand' -a help -d 'Print help information'

# general
complete -c nmcli -n '__no_subcommand' -a general -d 'General commands'
complete -c nmcli -n '__are_last_subcommands general' -a status -d 'Show overall status of NM. (default action)'
complete -c nmcli -n '__are_last_subcommands general' -a hostname -d 'Without argument get the current hostname, else set one'
complete -c nmcli -n '__are_last_subcommands general' -a permissions -d 'Show permissions for authenticated operations'
complete -c nmcli -n '__are_last_subcommands general' -a logging -d 'Get and change NM logging level and domains'

# networking
# TODO: fix the nasty quick fix of putting 'nmcli' before 'networking'. It prevents
# completion to work on 'nmcli networking ...' if there are switches after 'nmcli' and
# before 'networking'
complete -c nmcli -n '__no_subcommand' -a networking -d 'Query NetworkManager'
complete -c nmcli -n '__are_last_subcommands nmcli networking' -a on -d 'Enable networking control'
complete -c nmcli -n '__are_last_subcommands nmcli networking' -a off -d 'Disable networking control'
complete -c nmcli -n '__are_last_subcommands nmcli networking' -a connectivity -d 'Get network connectivity state'
complete -c nmcli -n '__are_last_subcommands nmcli networking connectivity' -a 'none portal limited full unknown'

# radio
complete -c nmcli -n '__no_subcommand' -a networking -d 'Query NetworkManager'
complete -c nmcli -n '__are_last_subcommands radio' -a wifi -d 'Show or set status of Wi-Fi'
complete -c nmcli -n '__are_last_subcommands radio' -a wwan -d 'Show or set status of WWAN'
complete -c nmcli -n '__are_last_subcommands radio' -a all -d 'Show or set wifi and wwan at the same time'
complete -c nmcli -n '__are_last_subcommands radio wifi' -a 'on off'
complete -c nmcli -n '__are_last_subcommands radio wwan' -a 'on off'
complete -c nmcli -n '__are_last_subcommands radio all' -a 'on off'

# monitor
complete -c nmcli -n '__no_subcommand' -a monitor -d 'Observe NetworkManager activity'

# connection

# device

__complete_wifi_connect

# agent
complete -c nmcli -n '__no_subcommand' -a agent -d 'Run nmcli as a secret or polkit agent'
complete -c nmcli -n '__are_last_subcommands agent' -a 'secret polkit all'
