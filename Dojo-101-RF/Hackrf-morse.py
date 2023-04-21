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

# This is a terrible, quick hack of a Morse code baseband file generator.
#
# Run to generate a file that contains baseband data you can later transmit
# with hackrf_transfer:
#
#     .\venv\Scripts\activate
#     python Hackrf-morse.py MYCALLSIGN baseband.cs8
#
# Use with hackrf_transfer as follows to transmit :
#
#     hackrf_transfer -s 8000000 -x 16 -a 0 -f 433500000 -b 1750000 -t baseband.cs8
#

import sys
import numpy

if len(sys.argv) != 3:
	print("Usage: <command> <message> <output file>")
	sys.exit(0)

message = sys.argv[1]

character_to_symbols_map = {
	'A': '.-',
	'B': '-...',
	'C': '-.-.',
	'D': '-..',
	'E': '.',
	'F': '..-.',
	'G': '--.',
	'H': '....',
	'I': '..',
	'J': '.---',
	'K': '-.-',
	'L': '.-..',
	'M': '--',
	'N': '-.',
	'O': '---',
	'P': '.--.',
	'Q': '--.-',
	'R': '.-.',
	'S': '...',
	'T': '-',
	'U': '..-',
	'V': '...-',
	'W': '.--',
	'X': '-..-',
	'Y': '-.--',
	'Z': '--..',
	'1': '.----',
	'2': '..---',
	'3': '...--',
	'4': '....-',
	'5': '.....',
	'6': '-....',
	'7': '--...',
	'8': '---..',
	'9': '----.',
	'0': '-----',
	' ': ' ',
	'É': '..-..',
	'.': '.-.-.-',
	',': '--..--',
	':': '---...',
	'?': '..--..',
	'\'': '.----.',
	'-': '-....-',
	'|': '-..-.',
	'(': '-.--.-',
	')': '-.--.-',
	'À':'.--.-',
	'<' : '-.-.-', # begin transmission
	'>' : '.-.-.' # end transmission
}


def make_baseband_samples(amplitude, length_units):
	frequency = 1000.0
	length_samples = int(round(unit_seconds * length_units * sample_rate))
	k = 2 * numpy.pi * frequency / sample_rate
	w = k * numpy.arange(length_samples)
	return numpy.exp(w * 1j) * amplitude

sample_rate = 8000000
unit_seconds = 0.1
amplitude = 127

dot_units = 1
dash_units = dot_units*3
space_internal_units = 1
space_letters_units = 3
space_words_units = 7

baseband_dot = make_baseband_samples(1, dot_units)
baseband_dash = make_baseband_samples(1, dash_units)
baseband_between_symbols = make_baseband_samples(0, space_internal_units)
baseband_between_letters = make_baseband_samples(0, space_letters_units - space_internal_units)
baseband_space = make_baseband_samples(0, space_words_units - space_letters_units - space_internal_units)

symbol_to_baseband_map = {
	'.': baseband_dot,
	'-': baseband_dash,
	' ': baseband_space,
}

# Start with a little silence.
output = [baseband_space]

for character in '<'+message.upper()+'>': # add "<" and ">" to respect procedure
	symbols = character_to_symbols_map[character]
	for symbol in symbols:
		output.append(symbol_to_baseband_map[symbol])
		output.append(baseband_between_symbols)
	output.append(baseband_between_letters)

# Append a little extra silence at the end.
output.append(baseband_space)

output = numpy.concatenate(output) * amplitude

output_int = numpy.empty((len(output) * 2,), dtype=numpy.int8)
output_int[0::2] = numpy.round(output.real)
output_int[1::2] = numpy.round(output.imag)

output_int.tofile(sys.argv[2])

