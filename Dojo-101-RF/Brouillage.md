# lutte contre le brouillage - jamming

## recommandation en cas de brouillage d'une liaison radio

1. Augmenter la puissance d'émission
2. Antenne plus grande (grand gain)
3. Changer d'amplacement
4. Changer de frequence
5. moyen de communication

## jammer pour attaque par rejeu

Pour des technologies utilisant des codes tournants:

1. Brouiller le récepteur
2. Capturer le signal de l'émetteur (sans que le récepteur le capte)
3. Rejouer le signal capturé

## Tester la résistance à une attaque par brouillage - en **laboratoire UNIQUEMENT**

### hackrf

### Wifi

Exemple de test de brouillage pour du Wifi 5Ghz - canal 36

```sh
hackrf_transfer -d <id> -s 20000000 -p 1 -x 47 -a 1 -f 2440000000 -c 127
```

Un materiel disposant de contremesure changera de canal ou de frequence.

### création de fichier IQ destiné aux tests de brouillage

```python
#!/usr/bin/env python

# Copyright (C) 2015 Jared Boone, ShareBrained Technology
# Copyright (C) 2023 Michael Vacarella, Taisen Solutions
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; see the file COPYING.  If not, write to
# the Free Software Foundation, Inc., 51 Franklin Street,
# Boston, MA 02110-1301, USA.

import sys
import numpy

if len(sys.argv) != 2:
	print("Usage: <command> <output file>")
	sys.exit(0)


print("JAMMING FOR LAB ONLY !")

sample_rate = 8000000
unit_seconds = 3
amplitude = 127

def make_baseband_samples(amplitude, length_units):
	frequency = 1000.0
	length_samples = int(round(unit_seconds * length_units * sample_rate))
	k = 2 * numpy.pi * frequency / sample_rate
	w = k * numpy.arange(length_samples)
	return numpy.exp(w * 1j) * amplitude

output = numpy.concatenate([make_baseband_samples(1, 1)]) * amplitude
output_int = numpy.empty((len(output) * 2,), dtype=numpy.int8)
output_int[0::2] = numpy.round(output.real)
output_int[1::2] = numpy.round(output.imag)
output_int.tofile(sys.argv[1])
```

## Wifi

1. Identifier la fréquence (2.4 ou 5 GHz)
2. Identifier le canal
3. Brouiller uniquement ce même canal
4. Étudier la réaction de la cible (changement de canal ? perte de dispo ? etc.)