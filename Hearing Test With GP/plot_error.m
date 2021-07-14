function H = plot_error(gprMdl)
    loss = resubloss(gprMdl)
    yvals(end+1) = loss
    H = plot(linspace(1, ii, ii), yvals)
end
