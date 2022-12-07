import Pkg
Pkg.active(".")
Pkg.add("Images")
Pkg.add("Plots")
Pkg.add("Colors")
Pkg.update()

using Images
using Plots; gr()
using Colors

#returns 256 long vector with elements representing normalised frequency
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

title_a = "fruitA"
title_b = "fruitB"

file_a = "fruitA.png"
file_b = "fruitB.png"

#universal filepath defintion
file_path = dirname(@__FILE__)
img_path_a = joinpath(file_path, file_a)
img_path_b = joinpath(file_path, file_b)

img_a = load(img_path_a)
img_b = load(img_path_b)

y_axis_a = myhistogram(img_a)
y_axis_b = myhistogram(img_b)
x_axis = collect(1:256)
    
#plot fruitA
plot_a = bar(x_axis, y_axis_a, title=title_a*" Histogram", legend=false)
ylabel!("Frequency")
xlabel!("Intensity")
annotate!(2,y_axis_a[2], "1", :red)
annotate!(10,y_axis_a[10], "2", :red)
annotate!(75,y_axis_a[75], "3", :red)
annotate!(107,y_axis_a[107], "4", :red)
annotate!(150,y_axis_a[150], "5", :red)
a = plot(img_a, title="fruitA Original", axis=nothing)
plot(plot_a, a, layout = (1,2), legend= false, reuse=false)
savefig(joinpath(file_path, "plot_a.png"))

#plot FruitB
plot_b = bar(x_axis,y_axis_b, title = title_b*" Histogram", legend=false)
ylabel!("Frequnecy")
xlabel!("Intensity")
annotate!(1,y_axis_b[1],"1", :red)
annotate!(60,y_axis_b[60],"2", :red)
annotate!(145,y_axis_b[145], "3", :red)
b = plot(img_b, title="fruitB Original",axis = nothing)
plot(plot_b, b, layout = (1,2), legend= false, reuse=false)
savefig(joinpath(file_path, "plot_b.png"))



   
