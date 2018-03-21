# -*- coding: utf-8 -*-
from itertools import chain


def escape(s):
    s = str(s) if type(s) == int else s
    chars = (ord(c) for c in s)
    # we don't want to escape azAz09/_
    unescaped = list(chain(range(47, 58), range(65, 91), range(97, 123))) + [95]

    res = []
    for c in chars:
        if c not in unescaped:
            if c < 128:
                res.append(r'\x{:02x}'.format(c))
            else:
                res.append(r'\u{:04x}'.format(c))
        else:
            res.append('{:c}'.format(c))

    return ''.join(res)


class FilterModule():
    def filters(self):
        return {
            'escape': escape
        }
