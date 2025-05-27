function plot_pdf(mean_val, covariance, data, sensortype, nBin, fig)
    color_axis = [1 0 0; 0 1 0; 0 0 1];

    [data_dim, data_length]= size(data);
    axis_type = ["x", "y", "z"];
    N = 100;
    figure(fig);
    clf
    for i = 1:data_dim
        
        sigma = sqrt(covariance(i, i));
        x_pdf = linspace(-4*sigma + mean_val(i), mean_val(i) + 4*sigma, N);
        y_pdf = normpdf(x_pdf, mean_val(i), sigma);

        if data_dim > 1
            subplot(2,data_dim,i);
        end

        hold on

        h = histogram(data(i, :),'BinEdges',linspace(-4*sigma + mean_val(i),4*sigma + mean_val(i),nBin), "Normalization", "pdf",'FaceColor', color_axis(i,:),'EdgeColor', color_axis(i,:));
        plot(x_pdf, y_pdf, 'LineWidth', 2, 'Color','black')
        
        title_string = sprintf("%s, %s-axis", sensortype, axis_type(i));
        
        legend("Hist", "Norm")
        title(title_string)
        xlabel("Sensor reading");
        ylabel("Probability density");
        xlim('tight')
        ylim([0, max(h.Values)*1.5])


        if data_dim > 1
            subplot(2,data_dim,i+data_dim);
        end
        normplot(data(i,:))
    end
end