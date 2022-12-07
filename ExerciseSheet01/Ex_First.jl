import Pkg
Pkg.activate(".")
Pkg.add("FileIO")
Pkg.add("ImageIO")
Pkg.add("Images")
Pkg.add("LinearAlgebra")
Pkg.add("Plots")
Pkg.update()

using FileIO
using ImageIO
using LinearAlgebra
using Images
using Plots

function myhistogram(img)
     output = collect(1:256)*0
     img2 = Float32.(img)*256
     for row in eachrow(img2)
          for s in row
               output[round(Int, s)+1] +=1
          end
     end
     (m,n) = size(img2)
     normalisator = 1/(m*n)
     return normalisator*output
end

function plot_histogram(img)
     filename = img*".png"    
     file_path = dirname(@__FILE__)
	img_path = joinpath(file_path,filename)
     #check if input is img
     try
          global img1 = load(img_path)
     catch
          println("Error: "* img_path * " is not grayscale")
     end
     y_axis = myhistogram(img1)
     x_axis = collect(1:256)
     t = bar(x_axis, y_axis, title=img*" Histogram", legend=false)
     ylabel!("Frequency")
     xlabel!("Intensity")
     savefig(t,"Histogram_"*img*".png")
end

function main()

     a = plot_histogram("fruitA")
     b = plot_histogram("fruitB")
end
main()


