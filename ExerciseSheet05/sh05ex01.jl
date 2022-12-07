using Images
using Plots
using TestImages

function gaussian_pyramid(img, binomial)
    img = img[1:2:end,1:2:end]
    img = imfilter(img,binomial)
    return img
end

function main()
    img = Gray.(testimage("lake"))

    #binomial mask
    pasc_3 = centered(1/8 * [1 3 3 1])


    img_1 = gaussian_pyramid(img, pasc_3)
    img_2 = gaussian_pyramid(img_1, pasc_3)
    img_3 = gaussian_pyramid(img_2, pasc_3)
    img_4 = gaussian_pyramid(img_3, pasc_3)
    img_5 = gaussian_pyramid(img_4, pasc_3)
    img_6 = gaussian_pyramid(img_5, pasc_3)
    
 
    #subsampling without gaussian filter approximation
    img_sub_1 = img[1:2:end,1:2:end]
    img_sub_2 = img_sub_1[1:2:end,1:2:end]
    img_sub_3 = img_sub_2[1:2:end,1:2:end]
    img_sub_4 = img_sub_3[1:2:end,1:2:end]
    img_sub_5 = img_sub_4[1:2:end,1:2:end]
    img_sub_6 = img_sub_5[1:2:end,1:2:end]

    #create plot img corrolaton
    plot_1 = plot(img_1,title="gaus 1",axis=nothing)
    plot_2 = plot(img_2,title="gaus 2",axis=nothing)
    plot_3 = plot(img_3,title="gaus 3",axis=nothing)
    plot_4 = plot(img_4,title="gaus 4",axis=nothing)
    plot_5 = plot(img_5,title="gaus 5",axis=nothing)
    plot_6 = plot(img_6,title="gaus 6",axis=nothing)

    #create plot subsampled img corrolation
    plot_sub_1 = plot(img_sub_1,title="no_gaus 1",axis=nothing)
    plot_sub_2 = plot(img_sub_2,title="no_gaus 2",axis=nothing)
    plot_sub_3 = plot(img_sub_3,title="no_gaus 3",axis=nothing)
    plot_sub_4 = plot(img_sub_4,title="no_gaus 4",axis=nothing)
    plot_sub_5 = plot(img_sub_5,title="no_gaus 5",axis=nothing)
    plot_sub_6 = plot(img_sub_6,title="no_gaus 6",axis=nothing)
    
    #plot corrolation
    result_1 = plot(plot_1,plot_2,plot_3,plot_4,plot_5,plot_6,layout=(2,3))
    savefig(result_1, "result_gaus.png")
    #plot subsampled corrolation
    result_2 = plot(plot_sub_1,plot_sub_2,plot_sub_3,plot_sub_4,plot_sub_5,plot_sub_6,layout=(2,3))
    savefig(result_2, "result_no_gaus.png")
    #comparison
end
main()
