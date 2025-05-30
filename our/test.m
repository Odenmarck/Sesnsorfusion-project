%% Quaternion representation
syms v_hatx v_haty v_hatz alpha beta real 
% Main task is to estimate time varying q vector using EKF
q = [cos(1/2 *alpha); 
    sin(1/2 * alpha) * v_hatx;
    sin(1/2 * alpha) * v_haty;
    sin(1/2 * alpha) * v_hatz];


alpha = beta;  %TEST1 

%alpha = beta + 2*pi; %TEST2


function q = get_quaternion(alpha, v)
    % alpha: Angle of rotation
    % v: axis of rotation
    v_hat = v/norm(v);
    q = [cos(1/2 * alpha);
        sin(1/2*alpha) * v_hat];
    q = q/norm(q); % Unit quaternion
end

q = get_quaternion(0, [1;1;1])
R_W_to_S  = Qq(q);

function q = rotation_to_quaternion(rotation_mat)
    q0 = 1/2 * sqrt(sum(diag(rotation_mat) + 1));
    q = [q0; 
        (rotation_mat(2,3) - rotation_mat(3, 2))/(4*q0);
        (rotation_mat(3,1) - rotation_mat(1,3))/(4*q0);
        (rotation_mat(1,2)- rotation_mat(2,1))/(4*q0)];
    q = q/norm(q);  %unit quaternion
    q = double(q);
    
end

q_replica = rotation_to_quaternion(R_W_to_S);

%%

%mean(meas.acc(1,:))
%data = meas.acc(1,:)
% -------- Variance of accelerometer --------
var_acc_x = var(meas.acc(1,:));
var_acc_y = var(meas.acc(2,:));
var_acc_z = var(meas.acc(3,:));

% -------- Variance of Gyroscope --------
var_gyro_x = var(meas.gyr(1,:));
var_gyro_y = var(meas.gyr(2,:));
var_gyro_z = var(meas.gyr(3,:));

% -------- Variance of Magnetometer --------
var_mag_x = var(meas.gyr(1,:));
var_mag_y = var(meas.gyr(2,:));
var_mag_z = var(meas.gyr(3,:));



clean_acc = clean_data_from_NAN(meas.acc);
clean_gyr = clean_data_from_NAN(meas.gyr);
clean_mag = clean_data_from_NAN(meas.mag);

expected_val_acc = [mean(clean_acc(1,:));
    mean(clean_acc(2,:));
    mean(clean_acc(3,:))];

expected_val_gyro = [mean(clean_gyr(1,:));
    mean(clean_gyr(2,:));
    mean(clean_gyr(3,:))];

expected_val_mag = [mean(clean_mag(1,:));
    mean(clean_mag(2,:));
    mean(clean_mag(3,:))];

cov_acc = cov(clean_acc.');
cov_gyro = cov(clean_gyr.');
cov_mag = cov(clean_mag.');
N = size(clean_acc,2);

histogram(clean_acc(1,:), "Normalization", "pdf")
%plot_pdf(expected_val_acc, cov_acc, clean_acc, "acc");
%plot_pdf(expected_val_gyro, cov_gyro, clean_gyr, "gyro")
plot_pdf(expected_val_mag, cov_mag, clean_mag, "mag")

%% Plotting task 2
N = size(clean_acc, 2);
figure();

subplot(1,3,1); % 1 row, 3 columns, first subplot
plot(clean_acc(1,:));
hold on 
yline(expected_val_acc(1), LineWidth=1.5, color = [1 0 0])
title('Accelerometer readings in x');
legend("Acc_x", "mean")
ylim([min(clean_acc(1,2:end)), max(clean_acc(1,2:end))])
xlim([0, N])

subplot(1,3,2); % second subplot
plot(clean_acc(2,:));
yline(expected_val_acc(2), LineWidth=1.5, color = [1 0 0])
title('Accelerometer readings in y');
legend("Acc_y", "mean")
ylim([min(clean_acc(2,2:end)), max(clean_acc(2,2:end))])
xlim([0, N])


subplot(1,3,3); % third subplot
plot(clean_acc(3,:));
yline(expected_val_acc(3), LineWidth=1.5, color = [1 0 0])
title('Accelerometer readings in z');
legend("Acc_z", "mean")
ylim([min(clean_acc(3,2:end)), max(clean_acc(3,2:end))])
xlim([0, N])

figure();
subplot(1,3,1); % 1 row, 3 columns, first subplot
plot(clean_gyr(1,:));
hold on 
yline(expected_val_gyro(1), LineWidth=1.5, color = [1 0 0])
title('Gyroscope readings in x');
legend("Gyro_x", "mean")
ylim([min(clean_gyr(1,2:end)), max(clean_gyr(1,2:end))])
xlim([0, N])

subplot(1,3,2); % second subplot
plot(clean_gyr(2,:));
yline(expected_val_gyro(2), LineWidth=1.5, color = [1 0 0])
title('Gyroscope readings in y');
legend("Gyro_y", "mean")
ylim([min(clean_gyr(2,2:end)), max(clean_gyr(2,2:end))])
xlim([0, N])


subplot(1,3,3); % third subplot
plot(clean_gyr(3,:));
yline(expected_val_gyro(3), LineWidth=1.5, color = [1 0 0])
title('Gyroscope readings in z');
legend("Gyro_z", "mean")
ylim([min(clean_gyr(3,2:end)), max(clean_gyr(3,2:end))])
xlim([0, N])

figure();
subplot(1,3,1); % 1 row, 3 columns, first subplot
plot(clean_mag(1,:));
hold on 
yline(expected_val_mag(1), LineWidth=1.5, color = [1 0 0])
title('Magnetometer readings in x');
legend("Mag_x", "mean")
ylim([min(clean_mag(1,3:end)), max(clean_mag(1,3:end))])
xlim([0, N])

subplot(1,3,2); % second subplot
plot(clean_mag(2,:));
yline(expected_val_mag(2), LineWidth=1.5, color = [1 0 0])
title('Magnetometer readings in y');
legend("Mag_y", "mean")
ylim([min(clean_mag(2,3:end)), max(clean_mag(2,3:end))])
xlim([0, N])


subplot(1,3,3); % third subplot
plot(clean_mag(3,:));
yline(expected_val_mag(3), LineWidth=1.5, color = [1 0 0])
title('Magnetometer readings in z');
legend("Mag_z", "mean")
ylim([min(clean_mag(3,3:end)), max(clean_mag(3,3:end))])
xlim([0, N])


%%

plot_pdf(expected_val_acc, cov_acc, clean_acc, "mag")

plot_pdf(expected_val_acc, cov_acc, clean_acc(2,:), "mag")

plot_pdf(expected_val_acc, cov_acc, clean_acc(3,:), "mag")


%%


syms q [4 1]
Qq(q).'



       

