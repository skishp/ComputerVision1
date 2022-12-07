using Plots;gr()


function ft(values)
    N = length(values)
    output = [] 
    factor = 1/sqrt(N)
    for u in range(0,N-1)
        ft_coef = 0
        for k in range(0,N-1)     
            ft_coef = ft_coef + values[k+1]*exp(-1im*2*pi*u*k*(1/N))
        end
        ft_coef = factor*ft_coef
        append!(output, ft_coef)
    end
    return output
end

function inverse_ft(ft_values)
    N = length(ft_values)
    inverse_output = []
    factor = 1/sqrt(N)
    for u in range(0,N-1)
        inverse_ft_coef = 0
        for k in range(0,N-1)     
            inverse_ft_coef = inverse_ft_coef + ft_values[k+1]*exp(-1im*2*pi*u*k*(1/N))
        end
        inverse_ft_coef = factor*inverse_ft_coef
        append!(inverse_output, inverse_ft_coef)
    end
    return inverse_output
end

function plot_signals(values, ft_values, inverse_ft_values, filepath)
    N = length(values)
    x_axis = collect(0:N-1)

    #create and save plot of original points
    original_points = plot(x_axis, values, title="Signal")
    savefig(original_points, joinpath(filepath,"original_points.png"))

    #create and save plot of frequency values
    freq_values = real.(ft_values)
    freq_plot = plot(x_axis, freq_values, title="frequency spectrum", legend=false)
    savefig(freq_plot, joinpath(filepath,"frequency_spectrum.png"))

    #create and save plot for real part of inverse ft values
    plot_real = plot(x_axis,real(inverse_ft_values), legend=false, title="recalculated original signal points")
    xlabel!("k")
    ylabel!("real part")

    #create and save plot for imaginary part of inverse ft values
    plot_imag = plot(x_axis,imag(inverse_ft_values), legend=false)
    xlabel!("k")
    ylabel!("imaginary part")

    #create plot with imaginary and real part in one plot
    inverse_points=plot(plot_real, plot_imag, layout=(2,1))
    savefig(inverse_points, joinpath(filepath,"inverse_points.png"))
end

function main()
    values = [2, 0, 3, 1]
    ft_values  = ft(values)
    inverse_ft_values = inverse_ft(ft_values)

    
    #save plots
    filepath = dirname(@__FILE__)
    plot_signals(values, ft_values, inverse_ft_values, filepath)


end

main()