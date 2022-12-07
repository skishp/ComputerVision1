import Pkg

Pkg.add("ImageFiltering")
Pkg.add("Images")
Pkg.add("ImageView")
Pkg.add("TestImages")
Pkg.add("Plots")


using TestImages
using Images
using ImageView
using Plots

img = Gray.(testimage("lake_gray"))
A= centered([[-1 -1 0] [-1 0 1] [0 1 1]])
k = imfilter(img, A, "replicate")
img_a = plot(img, title="Original", axis=nothing)
img_b = plot(k, title="With mask", axis= nothing)
plot(img_a,img_b, layout = (1,2), legend = false)