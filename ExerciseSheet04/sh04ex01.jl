using Plots
using FileIO
using ImageFiltering
using Images

function corner_detection_moravec(img, threshold)
    img = channelview(img)
    img = Gray.(img)

    #kirsch Filter
    k0 = centered([5 5 5; -3 0 -3; -3 -3 -3])
    k1 = centered([5 5 -3; 5 0 -3; -3 -3 -3])
    k2 = centered([5 -3 -3; 5 0 -3; 5 -3 -3])
    k3 = centered([-3 -3 -3; 5 0 -3; 5 5 -3])

    #define box filter
    box_filter = Kernel.box((5, 5))

    # apply kirsch filter on img
    d0 = imfilter(img, k0)
    d1 = imfilter(img, k1)
    d2 = imfilter(img, k2)
    d3 = imfilter(img, k3)

    #square filtered imgaes
    d0 = d0 .^ 2
    d1 = d1 .^ 2
    d2 = d2 .^ 2
    d3 = d3 .^ 2

    #apply box filter on squared kirsch filtered images
    d0 = imfilter(d0, box_filter)
    d1 = imfilter(d1, box_filter)
    d2 = imfilter(d2, box_filter)
    d3 = imfilter(d3, box_filter)

    #get pointwise maximum of the 4 images, avoid dividing by 0 by offsetting 0.01
    normalization_factor = max.(d0, d1, d2, d3) .+0.01

    #normalize the images
    d0 = d0 ./ normalization_factor
    d1 = d1 ./ normalization_factor
    d2 = d2 ./ normalization_factor
    d3 = d3 ./ normalization_factor

    #define m as pointwise minimum of the 4 images, afterwards check if p.w minimum > threshold
    m = min.(d0, d1, d2, d3)
    m[m .>= threshold] .= 1
    m[m .< threshold] .= 0

    return m
end

img_shapes1 = load("shapes1.png")
img_shapes1_noisy = load("shapes1_noisy.png")

function plot_junctions()
    img_shapes1_junctions = corner_detection_moravec(img_shapes1, 0.5)
    img_shapes1_noisy_junctions = corner_detection_moravec(img_shapes1_noisy, 0.5)
    
    result_plot= plot(plot(img_shapes1), plot(img_shapes1_noisy), plot(img_shapes1_junctions), plot(img_shapes1_noisy_junctions))
    savefig(result_plot, "result_ex01.png")
end
plot_junctions()
