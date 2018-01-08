import subprocess

from libqtile import widget


class Battery(widget.Battery):
    def _get_text(self):
        info = self._get_info()
        if not info:
            return self.error_message

        if self.hide_threshold and \
                info['now'] / info['full'] * 100.0 >= self.hide_threshold:
            return ''


class CheckUpdates(widget.CheckUpdates):
    def __init__(self, **config):
        super().__init__(**config)

    def _check_updates(self):
        updates = subprocess.run(self.cmd.split(), stdout=subprocess.PIPE)
        num_updates = str(len(updates.splitline()) - self.subtr)
        self._set_colour(num_updates)

        return self.display_format.format(**{"updates": num_updates})
