def fromhex(hex_value):
    return tuple(ord(c) for c in str(hex_value).decode('hex'))

class FilterModule():
    def filters(self):
        return {
            'fromhex': fromhex
            # When I'll use python3:
            # 'fromhex': bytes.fromhex
        }
