# To complete this branch we need to:
- find a way not to duplicate variable files
- find a way to avoid needing '-i /mnt'
- understand why the mount module does not want to mount '/sys' and '/dev'
- make sure play is idempotent (unmount and decrypt even if fail)
