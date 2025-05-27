addpath("our")
clear
load("data_z.mat","xhat", "meas");

color_x = [1 0 0];
color_y = [0 1 0];
color_z = [0 0 1];

% Get values for easier ploting
t = xhat.t;
gyr = clean_data_from_NAN(meas.gyr);
acc = clean_data_from_NAN(meas.acc);
mag = clean_data_from_NAN(meas.mag);

figure(1)
% subplot(3,1,1)
% hold on
% plot(t,gyr(1,:),"Color",color_x)
% plot(t,gyr(2,:),"Color",color_y)
% plot(t,gyr(3,:),"Color",color_z)

% legend("z")
% ylim('padded')
% xlim('tight')
% title("Gyro")

% subplot(3,1,2)
% hold on
% plot(t,acc(1,:),"Color",color_x)
% plot(t,acc(2,:),"Color",color_y)
% plot(t,acc(3,:),"Color",color_z)
% 
% legend('x', "y", "z")
% ylim('padded')
% xlim('tight')
% title("Accelerometer")
% 
% subplot(3,1,3)
% hold on
% plot(t,mag(1,:),"Color",color_x)
% plot(t,mag(2,:),"Color",color_y)
% plot(t,mag(3,:),"Color",color_z)
% 
% legend('x', "y", "z")
% ylim('padded')
% xlim('tight')
% title("Magnetometer")

% figure(1)
% subplot(2,2,1)
% plot(t(30:end),acc(1,30:end),"Color",color_x)
% legend('x')
% ylim([mean(acc(1,30:end))-0.2, mean(acc(1,30:end))+0.2])
% xlim("tight")
% title("Accelerometer, primary data set")
% 
% subplot(2,2,3)
% plot(t(30:end),acc(3,30:end),"Color",color_z)
% legend("z")
% ylim([mean(acc(3,30:end))-0.1, mean(acc(3,30:end))+0.1])
% xlim("tight")
% title("Accelerometer, primary data set")
% % 
