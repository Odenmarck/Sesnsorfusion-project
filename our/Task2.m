addpath("our")
load("data1min_x.mat","xhat", "meas");

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

cov_gyr = cov(gyr_clean.');
cov_acc = cov(acc_clean.');
cov_mag = cov(mag_clean.');





nBin = 30;


plot_pdf(mean_gyr, cov_gyr, gyr_clean, "Gyro", nBin)
plot_pdf(mean_acc, cov_acc, acc_clean, "Accelerometer", nBin)
plot_pdf(mean_mag, cov_mag, mag_clean, "Magnetometer", nBin)


%%
figure(1)
clf


% Gyro
lim = 3e-3;
nBin = 30;

subplot(3,3,1)
histogram(gyr_clean(1,:),'BinEdges',linspace(-lim,lim,nBin),'Normalization','probability','FaceColor',color_x)
title("Gyro x")
xlim([-lim,lim])

subplot(3,3,2)
histogram(gyr_clean(2,:),'BinEdges',linspace(-lim,lim,nBin),'Normalization','probability','FaceColor',color_y)
title("Gyro y")
xlim([-lim,lim])

subplot(3,3,3)
histogram(gyr_clean(3,:),'BinEdges',linspace(-lim,lim,nBin),'Normalization','probability','FaceColor',color_z)
title("Gyro z")
xlim([-lim,lim])

% Acc
lim = 6e-2;
nBin = 30;

subplot(3,3,4)
histogram(acc_clean(1,:),'BinEdges',linspace(mean(acc_clean(1,:))-lim,mean(acc_clean(1,:))+lim,nBin),'Normalization','probability','FaceColor',color_x)
title("Accelerometer x")
xlim([mean(acc_clean(1,:))-lim,mean(acc_clean(1,:))+lim])

subplot(3,3,5)
histogram(acc_clean(2,:),'BinEdges',linspace(mean(acc_clean(2,:))-lim,mean(acc_clean(2,:))+lim,nBin),'Normalization','probability','FaceColor',color_y)
title("Accelerometer y")
xlim([mean(acc_clean(2,:))-lim,mean(acc_clean(2,:))+lim])

subplot(3,3,6)
histogram(acc_clean(3,:),'BinEdges',linspace(mean(acc_clean(3,:))-lim,mean(acc_clean(3,:))+lim,nBin),'Normalization','probability','FaceColor',color_z)
title("Accelerometer z")
xlim([mean(acc_clean(3,:))-lim,mean(acc_clean(3,:))+lim])

% Mag
lim = 2;
nBin = 30;

subplot(3,3,7)
histogram(mag_clean(1,:),'BinEdges',linspace(mean(mag_clean(1,:))-lim,mean(mag_clean(1,:))+lim,nBin),'Normalization','probability','FaceColor',color_x)
title("Magnetometer x")
xlim([mean(mag_clean(1,:))-lim,mean(mag_clean(1,:))+lim])

subplot(3,3,8)
histogram(mag_clean(2,:),'BinEdges',linspace(mean(mag_clean(2,:))-lim,mean(mag_clean(2,:))+lim,nBin),'Normalization','probability','FaceColor',color_y)
title("Magnetometer y")
xlim([mean(mag_clean(2,:))-lim,mean(mag_clean(2,:))+lim])

subplot(3,3,9)
histogram(mag_clean(3,:),'BinEdges',linspace(mean(mag_clean(3,:))-lim,mean(mag_clean(3,:))+lim,nBin),'Normalization','probability','FaceColor',color_z)
title("Magnetometer z")
xlim([mean(mag_clean(3,:))-lim,mean(mag_clean(3,:))+lim])