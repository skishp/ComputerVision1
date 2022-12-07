using Images
using Plots
using TestImages
using LinearAlgebra


function gaussian_pyramid(img, binomial)
    img = img[1:2:end,1:2:end]
    img = imfilter(img,binomial)
    return img
end

#create laplacian with guassian_j = gaussian_k+1
function laplacian_pyramid(gaussian_k, gaussian_j, lambda)
    s = size(gaussian_k)
    laplacian_k = gaussian_k - imresize(gaussian_j, s)
    max_value = maximum(abs.(laplacian_k))
    for value in laplacian_k 
        if abs(value)< lambda*max_value
            value = 0
        end
    end
    return laplacian_k
end

#reconstruct original image using laplacian pyramid, laplacian_j = laplacian_k+1
function reconstruct(laplacian_k, laplacian_j)
    s  = size(laplacian_k)
    o_k = laplacian_k + imresize(laplacian_j,s)
    return o_k 
end

function main()
    img = Gray.(testimage("lake"))
    #binomial mask

    pasc_3 = centered(1/8 * [1 3 3 1])
    pasc_5 = centered(1/32 * [1 5 10 10 5 1])

    

    img_1 = gaussian_pyramid(img, pasc_5)
    img_2 = gaussian_pyramid(img_1, pasc_5)
    img_3 = gaussian_pyramid(img_2, pasc_5)
    img_4 = gaussian_pyramid(img_3, pasc_5)
    img_5 = gaussian_pyramid(img_4, pasc_5)
    img_6 = gaussian_pyramid(img_5, pasc_5)
    
    #plot(img_1)
    #print(size(img_1),size(img))
    laplacian_0 = laplacian_pyramid(img, img_1,0)
    laplacian_1 = laplacian_pyramid(img_1,img_2,0)
    laplacian_2 = laplacian_pyramid(img_2,img_3,0)
    laplacian_3 = laplacian_pyramid(img_3,img_4,0)
    laplacian_4 = laplacian_pyramid(img_4,img_5,0)
    laplacian_5 = laplacian_pyramid(img_5,img_6,0)
    laplacian_6 = img_6

    plot_laplacian_0 = plot(laplacian_pyramid(img, img_1,0), axis=nothing)
    plot_laplacian_1 = plot(laplacian_pyramid(img_1,img_2,0), axis=nothing)
    plot_laplacian_2 = plot(laplacian_pyramid(img_2,img_3,0), axis=nothing)
    plot_laplacian_3 = plot(laplacian_pyramid(img_3,img_4,0), axis=nothing)
    plot_laplacian_4 = plot(laplacian_pyramid(img_4,img_5,0), axis=nothing)
    plot_laplacian_5 = plot(laplacian_pyramid(img_5,img_6,0), axis=nothing)
    plot_laplacian_6 = plot(laplacian_6)
    
    
    r_5 = reconstruct(laplacian_5, laplacian_6)
    r_4 = reconstruct(laplacian_4, r_5)
    r_3 = reconstruct(laplacian_3, r_4)
    r_2 = reconstruct(laplacian_2, r_3)
    r_1 = reconstruct(laplacian_1, r_2)
    r_0 = reconstruct(laplacian_0, r_1)
    
    plot_reconstruct_5 = plot(r_5, axis=nothing)
    plot_reconstruct_4 = plot(r_4, axis=nothing)
    plot_reconstruct_3 = plot(r_3, axis=nothing)
    plot_reconstruct_2 = plot(r_2, axis=nothing)
    plot_reconstruct_1 = plot(r_1, axis=nothing)
    plot_reconstruct_0 = plot(r_0, axis=nothing)

    laplacian_0_02 = laplacian_pyramid(img, img_1,0.2)
    laplacian_1_02 = laplacian_pyramid(img_1,img_2,0.2)
    laplacian_2_02 = laplacian_pyramid(img_2,img_3,0.2)
    laplacian_3_02 = laplacian_pyramid(img_3,img_4,0.2)
    laplacian_4_02 = laplacian_pyramid(img_4,img_5,0.2)
    laplacian_5_02 = laplacian_pyramid(img_5,img_6,0.2)
    laplacian_6_02 = img_6
    
    result_laplacian = plot(plot_laplacian_1,plot_laplacian_2,plot_laplacian_3,plot_laplacian_4,plot_laplacian_5,plot_laplacian_6,layout=(2,3))
    savefig(result_laplacian,"result_laplacian.png")
    result = plot(plot_reconstruct_5,plot_reconstruct_4,plot_reconstruct_3,plot_reconstruct_2,plot_reconstruct_1,plot_reconstruct_0,layout=(2,3))
    savefig(result,"result_reconstruction.png")

    r_5_02 = reconstruct(laplacian_5_02,laplacian_6_02)
    r_4_02 = reconstruct(laplacian_4_02,r_5_02)
    r_3_02 = reconstruct(laplacian_3_02,r_4_02)
    r_2_02 = reconstruct(laplacian_2_02,r_3_02)
    r_1_02 = reconstruct(laplacian_1_02,r_2_02)
    r_0_02 = reconstruct(laplacian_0_02,r_1_02)
    
    
    #plot(plot_r_0_02, plot_reconstruct_0)
    #plot(laplacian_0)

end

main()