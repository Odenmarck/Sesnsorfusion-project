function plot_pdf(expected_val, covariance, data, sensortype)
    number_of_figures = size(data,1);
    axis_type = ["x", "y", "z"];
    N = 100;
    figure();
    for i = 1:number_of_figures
        sigma = sqrt(covariance(i, i));
        xaxis = linspace(-4*sigma + expected_val(i), expected_val(i) + 4*sigma, N);
        yaxis = normpdf(xaxis, expected_val(i), sqrt(covariance(i,i)));
        if number_of_figures > 1
            subplot(1,3,i);
        end
        histogram(data(i, :), "Normalization", "pdf")
        hold on
        plot(xaxis, yaxis, 'LineWidth', 2)
        hist_label = sprintf("Histogram for %s_%s", sensortype, axis_type(i));
        pdf_label = sprintf("PDF for %s_%s", sensortype, axis_type(i));
        legend(hist_label, pdf_label);
        xlabel("Value");
        ylabel("PDF");
      
  
    end
end
