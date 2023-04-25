#!/usr/bin/env python
# from: https://pysdr.org/content/iq_files.html, modifié pour hackrf

import sys
import numpy as np
import matplotlib.pyplot as plt

def write_iq(iqfile):
    """
    In Python, and numpy specifically, we use the tofile() function to store a numpy array to a file. 
    Here is a short example of creating a simple BPSK signal plus noise and saving it to a file in the same directory we ran our script from:
    """

    num_symbols = 10000
    x_symbols = np.random.randint(0, 2, num_symbols)*2-1 # -1 and 1's
    r = x_symbols

    # NOISE (comment if not needed)
    # n = (np.random.randn(num_symbols) + 1j*np.random.randn(num_symbols))/np.sqrt(2) # AWGN with unity power
    # r = x_symbols + n * np.sqrt(0.01) # noise power of 0.01

    # plot
    print(r)
    plt.plot(np.real(r), np.imag(r), '.')
    plt.grid(True)
    plt.show()

    # Now save to an IQ file
    r = r.astype(np.complex64) # Convert to 64
    r.tofile(iqfile +'.iq')
    """
    to Read the file:
    samples = np.fromfile('bpsk_in_noise.iq', np.complex64)
    """

    # file for hackrf one
    output_int = np.empty((len(r) * 2,), dtype=np.int8)
    output_int[0::2] = np.round(r.real)
    output_int[1::2] = np.round(r.imag)
    output_int.tofile(iqfile + ".cs8")

if __name__ == "__main__":
    write_iq("out")