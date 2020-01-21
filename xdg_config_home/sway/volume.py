#!/usr/bin/env python3

try:
    from pulsectl import Pulse
    pulse = Pulse()
    for sink in pulse.sink_list():
        if not sink.description.lower().startswith('built-in'):
            continue
        if sink.mute == 1:
            print('off')
        else:
            volume = pulse.volume_get_all_chans(sink)

            print(f"{100 * volume:.2f}")
except ImportError:
    print('n/a')
