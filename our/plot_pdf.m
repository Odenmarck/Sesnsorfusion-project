function plot_pdf(mean_val, covariance, data, sensortype, nBin)
    color_axis = [1 0 0; 0 1 0; 0 0 1];

    [data_dim, data_length]= size(data);
    axis_type = ["x", "y", "z"];
    N = 100;
    figure();
    for i = 1:data_dim
        
        sigma = sqrt(covariance(i, i));
        x_pdf = linspace(-4*sigma + mean_val(i), mean_val(i) + 4*sigma, N);
        y_pdf = normpdf(x_pdf, mean_val(i), sigma);

        if data_dim > 1
            subplot(1,3,i);
        end

        hold on

        histogram(data(i, :),'BinEdges',linspace(-4*sigma + mean_val(i),4*sigma + mean_val(i),nBin), "Normalization", "pdf",'FaceColor', color_axis(i,:))
        plot(x_pdf, y_pdf, 'LineWidth', 2)
        
        hist_label = sprintf("Histogram for %s_%s", sensortype, axis_type(i));
        pdf_label = sprintf("PDF for %s_%s", sensortype, axis_type(i));
        
        legend(hist_label, pdf_label);
        xlabel("Sensor reading");
        ylabel("Probability density");
        xlim('tight')

        
    end
end