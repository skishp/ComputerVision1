using Images
using Plots 
using Images
using ImageFiltering
include("sh04ex01.jl")


keypoints = load("keypoints.png")
keypoints_bool = Bool.(keypoints)


function roc(img, ground_truth)
    #calculate tpr,fpr
    tpr = sum(img .& ground_truth) / sum(ground_truth)
    fpr = sum(img .& .~ground_truth) / sum(.~ground_truth)

    return (tpr, fpr)
end

function receiver_characteristic(img)
    #check for true/false points
    tprs = zeros(101)
    fprs = zeros(101)
    for i in 0:100
        m = corner_detection_moravec(img, i / 100)
        m = Bool.(m)
        (tpr, fpr) = roc(m, keypoints_bool)
        tprs[i+1] = tpr
        fprs[i+1] = fpr
    end
    #plotting images
    x = 0:0.01:1
    tpr_plot = plot(x, tprs)
    title!("true positive rate")
    fpr_plot = plot(x, fprs)
    title!("false positive rate")
    return (tpr_plot, fpr_plot)
end

function plot_roc()
    (tpr1, fpr1) = receiver_characteristic(load("shapes1.png"))
    (tpr2, fpr2) = receiver_characteristic(load("shapes1_noisy.png"))
    result_plot = plot(tpr1, fpr1, tpr2, fpr2)
    savefig(result_plot, "result_ex02.png")
end

plot_roc()