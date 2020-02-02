- Ansible:
  - mkinitcpio and lightdm-plymouth should only be used if actually using plymouth
  - networkmanager: potentially use nmcli module instead of what I do
  - format: make some research on the error of vfat on logical sector size of 4MiB and change format role accordingly
  - prompt to reboot at the end of install play
  - use a git submodule for the aur module

- Qtile:
  - format code (possibly with black?)
  - Notifications for battery level

- Import gpg keys for:
  - spotify
  - tor-browser (gpg --auto-key-locate nodefault,wkd --locate-keys torbrowser@torproject.org)

Add xorg keyboard layout variant to us:
```
partial alphanumeric_keys
xkb_symbols "custom-altgr-intl" {

    include "us(basic)"
    name[Group1]= "English (US, custom algr-intl)";

    key <TLDE> { [ grave,        asciitilde,  dead_grave,      dead_tilde     ] };
    key <AB03> { [ c,            C,           ccedilla,        Ccedilla       ] };
    key <AB08> { [ comma,        less,        dead_cedilla,    guillemotleft  ] };
    key <AB09> { [ period,       greater,     dead_abovedot,   guillemotright ] };
    key <AC01> { [ a,            A,           agrave,          Agrave         ] };
    key <AC02> { [ s,            S,           scedilla,        Scedilla       ] };
    key <AC05> { [ g,            G,           gbreve,          Gbreve         ] };
    key <AC11> { [ apostrophe,   quotedbl,    dead_acute,      dead_diaeresis ] };
    key <AD03> { [ e,            E,           eacute,          Eacute         ] };
    key <AD07> { [ u,            U,           udiaeresis,      Udiaeresis     ] };
    key <AD08> { [ i,            I,           idotless,        Iabovedot      ] };
    key <AD09> { [ o,            O,           odiaeresis,      Odiaeresis     ] };
    key <AD11> { [ bracketleft,  braceleft,   oe,              OE             ] };
    key <AD12> { [ bracketright, braceright,  ae,              AE             ] };
    key <AE04> { [ 4,            dollar,      EuroSign                        ] };
    key <AE06> { [ 6,            asciicircum, dead_circumflex                 ] };

    include "level3(ralt_switch)"
};
```
