addpath("our")
load("data","xhat", "meas");

t = xhat.t;
gyr = clean_data_from_NAN(meas.gyr);
acc = clean_data_from_NAN(meas.acc);
mag = clean_data_from_NAN(meas.mag);

gyr_clean = gyr(:,1:end-10);
acc_clean = acc(:,1:end-10);
mag_clean = mag(:,20:end);

var_gyr = zeros(3,1);
var_acc = zeros(3,1);
var_mag = zeros(3,1);

mean_gyr = zeros(3,1);
mean_acc = zeros(3,1);
mean_mag = zeros(3,1);

for i = 1:3
    var_gyr(i) = var(gyr_clean(i,:));
    var_acc(i) = var(acc_clean(i,:));
    var_mag(i) = var(mag_clean(i,:));

    mean_gyr(i) = mean(gyr_clean(i,:));
    mean_acc(i) = mean(acc_clean(i,:));
    mean_mag(i) = mean(mag_clean(i,:));
end

var_gyr
var_acc
var_mag

mean_gyr
mean_acc
mean_mag