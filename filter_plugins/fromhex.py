import sys

def fromhex(hex_value):
    return tuple(ord(c) for c in str(hex_value).decode('hex'))


class FilterModule():
    def filters(self):
        if sys.version_info[0] == 3:
            return {'fromhex': bytes.fromhex}
        else:
            return {'fromhex': fromhex}
