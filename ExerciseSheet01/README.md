## Exercise 01  |   Histogram Calculation 
* Write a function `myhistogram` which takes a greyscale intensity image in the range [0,1] and returns a vector of length 256 with each element in the vector denoting the normalized frequency of the corresponding grey value. Apply a normalisation such that the resulting frequencies can be interpreted as probabilities. 
* Load the images `fruitA.png` and `fruitB.png`. Use your function `myhistogram` to calculate a histogram for each image. 
* Show the original images and your calculated histogram together in one plot. Make sure you label your plots appropriately.
* Try to find regions in the histograms which correspond to the objects in the image. 
* Extract from both images the rows with index 50 and 200, respectively and plot the profile of intensities along the x-axis. 

## Exercise 02  |   Neighborhood operations with local weighting
* (By hand) Consider the image I and F (defined in the solution file): Calculate the response of the mask for the position with the reference position of the mask in the center.   
* Apply the Mask F to the `lake_gray` image from the TestImage package. Display the result.

## Solution Ex. Sheet 01
A summary of the solution of both exercises can be found in `CV1_Ex01_Skivjani.pdf`. 
