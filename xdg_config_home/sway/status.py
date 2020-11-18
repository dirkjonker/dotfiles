#!/usr/bin/env python3
from time import strftime

from pulsectl import Pulse


def get_file(filename, fun):
    with open(filename) as f:
        return fun(f.read())


def battery():
    now = get_file('/sys/class/power_supply/BAT0/energy_now', float)
    full = get_file('/sys/class/power_supply/BAT0/energy_full', float)
    online = get_file('/sys/class/power_supply/AC/online', bool)
    pct = 100 * now / full
    return f'{pct:.2f}%'


def volume():
    pulse = Pulse()
    for sink in pulse.sink_list():
        if sink.description.lower().startswith('built-in'):
            volume = pulse.volume_get_all_chans(sink)
            return f"{100 * volume:.2f}"
    return 'n/a'


def wifi():
    return 'n/a'


def print_status(volume, wifi, battery):
    time = strftime('%Y-%m-%d %H:%M')
    line = ' \u2022 '.join([volume, wifi, battery, time])
    print(line)


if __name__ == '__main__':
    print_status(volume(), wifi(), battery())
