#!/usr/bin/env python3

for x in range(1, 256):
  print("\\x" + "{:02x}".format(x), end='')
print()