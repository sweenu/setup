def fromhex(hex_value):
    return tuple(ord(c) for c in str(hex_value).decode('hex'))


class FilterModule():
    def filters(self):
        return {
            # For Python2:
            # 'fromhex': fromhex
            'fromhex': bytes.fromhex
        }
