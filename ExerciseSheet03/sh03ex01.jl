using Plots
using FFTW
using Images
using FileIO
using Statistics
using ImageFiltering

# Exercise 1
# Histogram equalization

function histogram(img)
    img = img * 255.0 

    frequencies = zeros(256)
    numElements = 0

    for value in img                 # iterate through entire image
        bytevalue = floor(Int, real.(value))       # convert to an integer
        bytevalue = bytevalue + 1           # julia uses 1-indexing
        frequencies[bytevalue] = frequencies[bytevalue] + 1     # increase the frequency of that value
        numElements = numElements + 1
    end

    frequencies = frequencies / numElements # normalize

    return frequencies
end

function histogram_equalization()
    image = load("materials/bookstore_dark.tif")
    c_image = channelview(image)
    frequencies = histogram(c_image)
    cumulative_frequencies = cumsum(frequencies)
    equalized_image = Gray.(N0f8.(map((x) -> cumulative_frequencies[floor(Int, round(x * 255)) + 1], c_image)))
    
    new_frequencies = histogram(equalized_image)
    new_cumulative_frequencies = cumsum(new_frequencies)

    p1 = plot(image)
    title!("original")
    p2 = plot(equalized_image)
    title!("equalized")
    p3 = bar(new_frequencies)
    title!("histogram")
    xlabel!("color value")
    ylabel!("frequency")
    p4 = bar(new_cumulative_frequencies)
    title!("cumulative histogram")
    xlabel!("color value")
    ylabel!("cum. frequency")
    plot(p1, p2, p3, p4)
    savefig("histogram_equalization.png")
end
