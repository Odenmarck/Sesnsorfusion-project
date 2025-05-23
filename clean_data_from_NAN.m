function clean_data = clean_data_from_NAN(data)
% n = size(data, 2)
% clean_data = [];
% for i = 2:n
%     data(1,i)
%     if isnan(data(i))
%         clean_data = [clean_data, data(i-1)];
%     end
%     clean_data = [clean_data, clean_data(i)];
% end
% end

clean_data = data;

[n, ~] = size(clean_data);
for i = 1:n                                         % Loop through all rows in data
    while sum(isnan(clean_data(i,:)),'all') ~= 0    % Loop until no NaNs remain. (This is needed because there could be more than one NaN in a row)
        try
           clean_data(i,find(isnan(clean_data(i,:)))) = clean_data(i,find(isnan(clean_data(i,:)))-1);   % Finds all NaNs and replaces them with the value before them.
        catch
           clean_data(i,1) = 0;                     % If the first data point is NaN, it is set to 0
        end
    end
end