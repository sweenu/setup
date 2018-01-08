import parse
from subprocess import run, PIPE
from pathlib import Path
from time import time

import notify2
from pynput import mouse
from dbus.exceptions import DBusException


def nb_monitors(enabled=False):
    if enabled:
        cp = run(['xrandr', '--listmonitors'], stdout=PIPE)
        output = cp.stdout.decode('utf-8')
        return int(parse.search('Monitors: {}\n', output)[0])
    else:
        cp = run(['xrandr'], stdout=PIPE)
        return cp.stdout.count(b' connected')


def screenshot(save=True, copy=True):
    def f(qtile):
        shot = run(['maim'], stdout=PIPE)
        if save:
            path = Path.home() / 'Pictures'
            path /= f'screenshot_{str(int(time() * 100))}.png'
            with open(path, 'wb') as sc:
                sc.write(shot.stdout)
        if copy:
            run(['xclip', '-selection', 'clipboard', '-t', 'image/png'],
                input=shot.stdout)

    return f


def init_notifications(app_name):
    try:
        notify2.init(app_name)
    except DBusException:
        from libqtile.log_utils import logger
        logger.exception('DBus connection failed')


class Backlight:
    @classmethod
    def get_brightness(self):
        return int(run(['xbacklight', '-get'], stdout=PIPE).stdout)

    @classmethod
    def set_brightness(self, percentage):
        run(['xbacklight', f'-set', str(percentage)])

    def change_backlight(self, action):
        """Increase or decrease bightness."""
        """Takes 'dec' or 'inc' as parameter. Goes 1% percent at a time from
        1% to 39% and 10% at a time from 40% to 100%."""
        def f(qtile):
            brightness = self.get_brightness()
            if brightness != 1 or action != 'dec':
                if (brightness > 49 and action == 'dec') \
                        or (brightness > 39 and action == 'inc'):
                    run(['xbacklight', f'-{action}', '10', '-fps', '10'])
                else:
                    run(['xbacklight', f'-{action}', '1'])
        return f


def turn_off_screen(qtile):
    """Turn off the laptop's screen."""
    """Uses xset if there is only one screen, else it will set backlight to
    zero. In both case, moving he mouse will trun on screen."""
    nb_screens = len(qtile.conn.pseudoscreens)

    if nb_screens == 1:
        run(['xset', 'dpms', 'force', 'off'])
    elif nb_screens == 2:
        current_brightness = Backlight.get_brightness()
        Backlight.set_brightness(0)

        def on_move(x, y):
            if x > 1920:
                Backlight.set_brightness(current_brightness)
                raise mouse.Listener.StopException

        mouse.Listener(on_move=on_move).start()


class SoundCard():
    def __init__(self, primary_card_name):
        self.primary_card = primary_card_name

    def get_current_sink(self):
        cp = run(['pactl', 'info'], stdout=PIPE)
        output = cp.stdout.decode('utf-8')
        return parse.search('Default Sink: {}\n', output)[0]

    def list_sinks(self):
        """Generator that yields for each sink, the sink and card name."""
        cp = run(['pactl', 'list', 'sinks'], stdout=PIPE)
        output = cp.stdout.decode('utf-8')
        for sink in output.split('\nSink'):
            sink_name = parse.search('Name: {}\n', sink)[0]
            card_name = parse.search('alsa.card_name = "{}"', sink)[0]
            yield sink_name, card_name

    def set_new_sink(self, sink_card_tuple):
        run(['pactl', 'set-default-sink', sink_card_tuple[0]])

    def list_sink_inputs(self):
        cp = run(['pactl', 'list', 'short', 'sink-inputs'], stdout=PIPE)
        output = cp.stdout.decode('utf-8')
        return {line.split()[0] for line in output.split('\n') if line}

    def move_sink_input(self, name, new_sink):
        run(['pactl', 'move-sink-input', name, new_sink])

    def get_current_profile(self):
        cp = run(['pactl', 'list', 'cards'], stdout=PIPE)
        cp = run(['grep', 'Active'], stdout=PIPE, input=cp.stdout)

        return 'hdmi' if b'hdmi' in cp.stdout else 'analog'

    def set_profile(self, profile):
        cmd = f'output:{profile}-stereo+input:analog-stereo'
        run(['pactl', 'set-card-profile', self.primary_card, cmd])

    def change_sink(self, direction):
        def f(qtile):
            sinks = list(self.list_sinks())

            # get the index of the tuple containing the current default sink
            current_sink = self.get_current_sink()
            for index, tup in enumerate(sinks):
                if current_sink in tup:
                    default_sink_index = index
                    break

            if direction == 'next':
                new_sink = sinks[default_sink_index - 1]
            elif direction == 'prev':
                new_sink = sinks[(default_sink_index + 1) % len(sinks)]

            self.set_new_sink(new_sink)
            notify2.Notification('Sound Card', new_sink[1]).show()

            # move current sink inputs, if any, to the new default sink
            sink_inputs = self.list_sink_inputs()
            if sink_inputs:
                for sink_input in sink_inputs:
                    self.move_sink_input(sink_input, new_sink[0])

        return f

    def swap_profile(self):

        def f(qtile):
            profile = self.get_current_profile()
            if profile == 'analog':
                self.set_profile('hdmi')
                notify2.Notification('Sound Profile', 'HDMI').show()
            elif profile == 'hdmi':
                self.set_profile('analog')
                notify2.Notification('Sound Profile', 'Analog').show()

        return f
