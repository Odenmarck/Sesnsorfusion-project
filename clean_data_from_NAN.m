function clean_data = clean_data_from_NAN(data)
n = size(data, 2)
clean_data = [];
for i = 2:n
    data(1,i)
    if isnan(data(i))
        clean_data = [clean_data, data(i-1)];
    end
    clean_data = [clean_data, clean_data(i)];
end
end