function __fish_nmcli_no_subcommand --description 'Test if nmcli has yet to be given the subcommand'
    for i in (commandline -opc)
        if contains -- $i help general networking radio connection device agent monitor
            return 1
        end
    end
    return 0
end

function __fish_print_wifi_ssid -d 'Print a list of available wifi SSIDs with their connecion rate seperated by semicolons'
    nmcli --terse device wifi | cut -d : -f 2,5
end

function __fish_print_fields -d 'Print available fields for the current command'
    switch $argv
    case wifi
        echo 'name ssid ssid-hex bssid mode chan freq signal bars security wpa-flags rsn-flags device active in-use dbus-path'
    end
end

function __complete_wifi_connect -d 'Completions for nmcli device wifi connect'
    for wifi in (__fish_print_wifi_ssid)
        set -l ssid (echo $wifi | cut -d : -f 1)
        set -l rate (echo $wifi | cut -d : -f 2)
        complete -c nmcli -n '__fish_are_last_subcommands wifi connect' -a $ssid -d $rate
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
complete -c nmcli -n __fish_nmcli_no_subcommand -a help -d 'Print help information'

# general

# networking
complete -c nmcli -n '__fish_nmcli_no_subcommand' -a networking -d 'Query NetworkManager'
complete -c nmcli -n '__fish_are_last_subcommands networking' -a on -d 'Enable networking control'
complete -c nmcli -n '__fish_are_last_subcommands networking' -a off -d 'Disable networking control'
complete -c nmcli -n '__fish_are_last_subcommands networking' -a connectivity -d 'Get network connectivity state'

  # networking connectivity
complete -c nmcli -n '__fish_are_last_subcommands networking connectivity' -a 'none portal limited full unknown'

# radio
complete -c nmcli -n '__fish_nmcli_no_subcommand' -a networking -d 'Query NetworkManager'
complete -c nmcli -n '__fish_are_last_subcommands radio' -a wifi -d 'Show or set status of Wi-Fi'
complete -c nmcli -n '__fish_are_last_subcommands radio' -a wwan -d 'Show or set status of WWAN'
complete -c nmcli -n '__fish_are_last_subcommands radio' -a all -d 'Show or set wifi and wwan at the same time'
  # radio wifi
complete -c nmcli -n '__fish_are_last_subcommands radio wifi' -a 'on off'
  # radio wwan
complete -c nmcli -n '__fish_are_last_subcommands radio wwan' -a 'on off'
  # radio all
complete -c nmcli -n '__fish_are_last_subcommands radio all' -a 'on off'

# monitor
complete -c nmcli -n '__fish_nmcli_no_subcommand' -a monitor -d 'Observe NetworkManager activity'

# connection

# device

  # device wifi connect
__complete_wifi_connect

# agent
complete -c nmcli -n '__fish_nmcli_no_subcommand' -a agent -d 'Run nmcli as a secret or polkit agent'
complete -c nmcli -n '__fish_are_last_subcommands agent' -a 'secret polkit all'
