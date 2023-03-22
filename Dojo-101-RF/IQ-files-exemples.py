# from: https://pysdr.org/content/iq_files.html

import numpy as np
import matplotlib.pyplot as plt

function write_iq():

    """
    In Python, and numpy specifically, we use the tofile() function to store a numpy array to a file. 
    Here is a short example of creating a simple BPSK signal plus noise and saving it to a file in the same directory we ran our script from:
    """

    num_symbols = 10000

    x_symbols = np.random.randint(0, 2, num_symbols)*2-1 # -1 and 1's
    n = (np.random.randn(num_symbols) + 1j*np.random.randn(num_symbols))/np.sqrt(2) # AWGN with unity power
    r = x_symbols + n * np.sqrt(0.01) # noise power of 0.01
    print(r)
    plt.plot(np.real(r), np.imag(r), '.')
    plt.grid(True)
    plt.show()

    # Now save to an IQ file
    print(type(r[0])) # Check data type.  Oops it's 128 not 64!
    r = r.astype(np.complex64) # Convert to 64
    print(type(r[0])) # Verify it's 64
    r.tofile('bpsk_in_noise.iq') # Save to file

function read_iq():

    """
    Now examine the details of the file produced and check how many bytes it is. 
    It should be num_symbols * 8 because we used np.complex64, which is 8 bytes per sample, 4 bytes per float (2 floats per sample).
    Using a new Python script, we can read in this file using np.fromfile(), like so:
    """

    samples = np.fromfile('bpsk_in_noise.iq', np.complex64) # Read in file.  We have to tell it what format it is
    print(samples)

    # Plot constellation to make sure it looks right
    plt.plot(np.real(samples), np.imag(samples), '.')
    plt.grid(True)
    plt.show()

