addpath("our")
load("data_z.mat","xhat", "meas");

t = xhat.t;
gyr = clean_data_from_NAN(meas.gyr);
acc = clean_data_from_NAN(meas.acc);
mag = clean_data_from_NAN(meas.mag);

gyr_clean = gyr(:,30:end-30);
acc_clean = acc(:,30:end-30);
mag_clean = mag(:,30:end-30);

var_gyr = zeros(3,1);
var_acc = zeros(3,1);
var_mag = zeros(3,1);

mean_gyr = zeros(3,1);
mean_acc = zeros(3,1);
mean_mag = zeros(3,1);

for i = 1:3
    mean_gyr(i) = mean(gyr_clean(i,:));
    mean_acc(i) = mean(acc_clean(i,:));
    mean_mag(i) = mean(mag_clean(i,:));

    var_gyr(i) = var(gyr_clean(i,:));
    var_acc(i) = var(acc_clean(i,:));
    var_mag(i) = var(mag_clean(i,:));
end

mean_gyr
mean_acc
mean_mag

var_gyr
var_acc
var_mag

cov_gyr = cov(gyr_clean.')
cov_acc = cov(acc_clean.')
cov_mag = cov(mag_clean.')





nBin = 60;

% plot_pdf(mean_gyr, cov_gyr, gyr_clean, "Gyro", 100, 1)
% plot_pdf(mean_acc, cov_acc, acc_clean, "Accelerometer", 100, 2)
% plot_pdf(mean_mag, cov_mag, mag_clean, "Magnetometer", 100, 3)

% fftAccZ = real(fft(acc_clean(3,:)-mean_acc(3)));
% fftAccX = real(fft(acc_clean(1,:)-mean_acc(1)));
% figure(1)
% plot(fftAccZ)
% figure(2)
% plot(acc_clean(3,:)-mean_acc(3))
% figure(3)
% plot(fftAccX)
% figure(4)
% plot(acc_clean(1,:)-mean_acc(1))

y = highpass(acc_clean(3,:),10,100);
plot(y)