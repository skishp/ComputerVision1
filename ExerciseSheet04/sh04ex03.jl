using ImageFiltering
using LinearAlgebra
using Images
using Plots

function order_lambdas(vals)
    x = vals[1]
    y = vals[2]
    if x >= y
        return (x, y)
    else
        return (y, x)
    end
end

function structure_tensor()
    #define sobel filter
    (sx, sy) = Kernel.sobel()

    #calculate Image gradient,magnitude
    img = Gray.(channelview(load("shapes1.png")))
    Ix = imfilter(img, sx)
    Iy = imfilter(img, sy)
    
    magnitude = sqrt.(Ix .^ 2 + Iy .^ 2)
    magnitude_plot = plot(magnitude)
    title!("magnitude")

    G = Kernel.gaussian(3)
    S_iter = zip(imfilter(Ix .^2, G), imfilter(Ix .* Iy, G), imfilter(Iy .* Ix, G), imfilter(Iy .^ 2, G))

    homogeneous_area = copy(img)
    edge = copy(img)
    corner = copy(img)

    for (i, (a, b, c, d)) in enumerate(S_iter)
        M = [a c; b d]
        vals, vecs = eigen(M)
        (x, y) = order_lambdas(vals)

        threshold1 = 0.002
        if abs(x) < threshold1
            homogeneous_area[i] = 1
        else
            homogeneous_area[i] = 0
        end
        
        if abs(x) > threshold1 && abs(y) < threshold1
            edge[i] = 1
        else
            edge[i] = 0
        end

        if abs(y) > threshold1
            corner[i] = 1
        else
            corner[i] = 0
        end
    end

    homo_plot = plot(homogeneous_area)
    title!("homogeneous")

    edge_plot = plot(edge)
    title!("edge")

    corner_plot = plot(corner)
    title!("corner")

    result_plot = plot(magnitude_plot, homo_plot, edge_plot, corner_plot)
    savefig(result_plot,"result_ex03.png")
end
structure_tensor()