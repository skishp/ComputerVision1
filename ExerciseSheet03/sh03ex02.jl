using Plots
using FFTW
using Images
using FileIO
using Statistics
using ImageFiltering

include("colorgrad.jl")

# Exercise 2

function exercise2()
    image = load("materials/circles.png")

    sobel_x = centered([1 0 -1; 2 0 -2; 1 0 -1])
    sobel_y = centered([1 2 1; 0 0 0; -1 -2 -1])

    Ix = imfilter(image, sobel_x)
    Iy = imfilter(image, sobel_y)

    mag = sqrt.(Ix.^2 .+ Iy.^2)
    s = maximum(mag)
    mag = mag ./ s

    orient = atan.(Iy, Ix)

    n = 8

    startx = 145
    starty = 40

    subx = startx:(startx+n-1)
    suby = starty:(starty+n-1)

    submag = mag[subx, suby]
    suborient = orient[subx, suby]

    pts = vec([(i, j) for i=1:n, j=1:n])

    function q(x, y)
        i = floor(Int, x)
        j = floor(Int, y)
        j = n - j + 1
        s = submag[i, j]
        if s < 0.2
            return (0, 0)
        else
            angle = suborient[i, j] 
            return (cos(angle), sin(angle)) .* s
        end
    end

    p1 = plot(image)
    title!("original image")
    p2 = plot(mag)
    title!("magnitude")
    p3 = plot(ColorGrad.colorgrad(orient, mag, 0.01))
    title!("orientation")
    p4 = plot(submag)
    quiver!(pts, quiver=q)

    plot(p1, p2, p3, p4, size=(800, 800))
    savefig("exercise2.png")
end