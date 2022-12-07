## Exercise 01  |   Discrete Fourier Transform
Given the discrete signal with N = 4 
|k  |s[k]|
|---|---|
|0  |2  |
|1  |0  |
|2  |3  |
|3  |1  |
* Use the discrete Fourier transform to calculate the corresponding signal representation in the frequency domain. 
`S[u]= 1/sqrt(N) Sum_k s[k]*exp[-i 2 pi u/N  * k]`
where N is the number of sample points. Use this formula to instead of packages. 
* Reconstruct the original signal by using the inverse Discrete Fourier Transform formula.
* Plot the original points, frequency spectrum, and your reconstructed signal. 

## Exercise 02  |   Fourier Transform for Image Quality Assessment
Load the images `flower01.png` and `flower02.png`. 
* Apply the 2D-Fourier transform to both images, take the absolute value at each position and shift the frequency values so that the DC component is centered in the middle.
* To decrease the effect of low frequencies, multiply both spectra with a high-pass filter. For this purpose, generate a Gaussian G(u,v) with standard deviation equal to half of the size of the image.
* In order to assess the energy content of the highpass filtered image, calculate the sum of squared amplitudes for all frequency values. A sharp image should have a higher energy than a blurred one. 
* Plot the filtered amplitude spectra and annotate them with their energy. 