#!/usr/bin/env python
import argparse
from subprocess import run

from pynput import mouse

def turn_off_screen(screen_offset: int, output: str = "*") -> None:
    def on_move(x: int, y: int):
        if x > screen_offset:
            run(["swaymsg", "output", output, "dpms", "on"])
            raise mouse.Listener.StopException

    mouse.Listener(on_move=on_move).start()

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("screen_offset", type=int)
    parser.add_argument("output", nargs="?")

    args = parser.parse_args()

    params = [args.screen_offset]
    if args.output:
        params.append(args.output)

    turn_off_screen(*params)
