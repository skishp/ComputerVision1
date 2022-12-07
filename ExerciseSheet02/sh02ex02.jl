
using Images
using FFTW
using ImageFiltering
using Plots
using Statistics

#2d ft Gaussian functionn
#returns matriz half of vertical size of img
#with each element representing 2d-ft gaussian value
function ft_gaussian((n,m),sigma)
    (k,l)= (round(Int,n/2),round(Int,m/2))
    gaussian_img = Float64.(zeros((n,m)))
    faktor = (pi^2)*sigma
    for i in range(0,n-1)
        for j in range(0,m-1)
            
            t = (i-k)^2 + (j-l)^2
            gaussian_img[i+1,j+1]=exp(-2*t*faktor)
        end
    end
    return gaussian_img
end

#get maximum of given matrix
function get_maximum(img)
    maximum = 0
    for s in img
        if maximum < s
            maximum = s
        end
    end
    return maximum
end

#calculate and return engergy value of given matrix
function get_energy(img)
    counter  = 0
    for value in img
        counter += value^2
    end
    return counter
end

function main()
    #load images
    filepath = dirname(@__FILE__)
    filepath_img01 = joinpath(filepath, "flower01.png")
    filepath_img02 = joinpath(filepath, "flower02.png") 
    img01 = load(filepath_img01)
    img02 = load(filepath_img02)
    
    #get abs of fft images
    ft_img01= fft(channelview(img01))
    abs_ft_img01 = abs.(ft_img01)
    #abs_ft_img01 = abs_matrix(ft_img01)
    ft_img02= fft(channelview(img02))
    abs_ft_img02= abs.(ft_img02)
    #abs_ft_img02 = abs_matrix(ft_img02)

    #shift abs_img to center
    ft_shift_abs_img01 = fftshift(abs_ft_img01)
    ft_shift_abs_img02 = fftshift(abs_ft_img02)

    #size of ft_shift_abs_img01
    (n,m) = size(ft_shift_abs_img01)
    (k,l)= (round(Int,n/2),round(Int,m/2))

    img_cut = abs_ft_img01[begin:k,begin:m]
    sigma = std(img_cut)
    sigma = sigma*22000
    #sigma = k*m

    
    #get gaussian matrix 
    gaussian_ft_img01 = ft_gaussian((n,m),1/sigma)
    gaussian_ft_img02 = ft_gaussian((n,m),1/sigma)
    a = get_maximum(gaussian_ft_img01)


    #define f(u,v) as 1-G(u,v)
    A = Float64.(ones(size(gaussian_ft_img01)))
    B = Float64.(ones(size(gaussian_ft_img02)))
    f_gaussian_ft_img01 = A - gaussian_ft_img01
    f_gaussian_ft_img02 = B - gaussian_ft_img02

    #apply highfilter mask onto abs image
    filtered_f_gaussian01 = f_gaussian_ft_img01 .*ft_shift_abs_img01 
    filtered_f_gaussian02 = f_gaussian_ft_img02 .*ft_shift_abs_img02

    #get energy of filtered image
    energy_f01 = round(get_energy(filtered_f_gaussian01),digits=4)
    energy_f02 = round(get_energy(filtered_f_gaussian02),digits=4)

    #energy value to string for title of plot
    str_energy_f01 = string(energy_f01)
    str_energy_f02 = string(energy_f02)

    #save images
    h_filtered_01 = plot(heatmap(filtered_f_gaussian01, axis=nothing, color=:greys ),title="filtered_image_01 with energy "*str_energy_f01)
    savefig(h_filtered_01, joinpath(filepath,"filtered_01.png"))
    h_gaussian_01 = plot(heatmap(gaussian_ft_img01, axis=nothing, color=:greys),title="gaussian filter img 01")
    savefig(h_gaussian_01, joinpath(filepath,"gaussian_01.png"))
    h_f_gaussian_01 = plot(heatmap(f_gaussian_ft_img01, axis=nothing, color=:greys, clim=(0,0.8)),title="filter f(u,v)")
    savefig(h_f_gaussian_01, joinpath(filepath,"f_gaussian_01.png"))
    

    h_filtered_02 = plot(heatmap(filtered_f_gaussian02, axis=nothing, color=:greys),title="filtered_image_02  with energy "*str_energy_f02)
    savefig(h_filtered_02, joinpath(filepath,"filtered_02.png"))
    h_gaussian_02 = plot(heatmap(gaussian_ft_img02, axis=nothing, color=:greys),title="gaussian_image_02")
    savefig(h_gaussian_02, joinpath(filepath,"gaussian_02.png"))
    h_f_gaussian_02 = plot(heatmap(f_gaussian_ft_img02, axis=nothing, color=:greys, clim=(0,0.8)),title="filter f(u,v)")
    savefig(h_f_gaussian_02, joinpath(filepath,"f_gaussian_02.png"))


    
end

main()