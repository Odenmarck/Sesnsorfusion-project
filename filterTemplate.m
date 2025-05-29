function [xhat, meas] = filterTemplate(calAcc, calGyr, calMag)
addpath("our")
% FILTERTEMPLATE  Filter template
%
% This is a template function for how to collect and filter data
% sent from a smartphone live.  Calibration data for the
% accelerometer, gyroscope and magnetometer assumed available as
% structs with fields m (mean) and R (variance).
%
% The function returns xhat as an array of structs comprising t
% (timestamp), x (state), and P (state covariance) for each
% timestamp, and meas an array of structs comprising t (timestamp),
% acc (accelerometer measurements), gyr (gyroscope measurements),
% mag (magnetometer measurements), and orint (orientation quaternions
% from the phone).  Measurements not availabe are marked with NaNs.
%
% As you implement your own orientation estimate, it will be
% visualized in a simple illustration.  If the orientation estimate
% is checked in the Sensor Fusion app, it will be displayed in a
% separate view.
%
% Note that it is not necessary to provide inputs (calAcc, calGyr, calMag).

%% Setup necessary infrastructure
import('com.liu.sensordata.*');  % Used to receive data.

%% Filter settings
t0 = [];  % Initial time (initialize on first data received)
nx = 4;   % Assuming that you use q as state variable.
% Add your filter settings here.

% Current filter state.
x = [1; 0; 0 ;0];
P = eye(nx, nx);
Rw = [ 0.1110   -0.0721    0.0001;
    -0.0721    0.0634   -0.0004;
    0.0001   -0.0004    0.0019] * 1e-4;

Ra = [ 0.0890   -0.0003    0.0030;
    -0.0003    0.0861    0.0212;
    0.0030    0.0212    0.2806] * 1e-3;
Rm =    [ 4.5917   -2.5708  -13.7295;
       -2.5708    1.6312    7.8674;
         -13.7295    7.8674   41.9239];

mx = 13.2156;
my = -7.5914;
mz = -40.2631;

m0 = [0; sqrt(mx^2 + my^2); mz];

bias_acc = [0; 0; 9.82] - [0.0841; 0.01167; 9.6923]; % bias = exp - exp_hat
bias_gyr = [0; 0; 0] - [0.7070; 0.4956; 0.3697]*1e-5;
bias_mag = zeros(3,1);

T = 0.01;
accTol = 0.2;       % Accelerometer outlier detection tuning
magTol = 10;        % Magnetometer outlier detection tuning
magAlpha = 0.01;    % Magnetometer outlier detection tuning
magExpected = [2.0534; -17.7476; -21.0806];    % magExpected_0

% Saved filter states.
xhat = struct('t', zeros(1, 0),...
    'x', zeros(nx, 0),...
    'P', zeros(nx, nx, 0));

meas = struct('t', zeros(1, 0),...
    'acc', zeros(3, 0),...
    'gyr', zeros(3, 0),...
    'mag', zeros(3, 0),...
    'orient', zeros(4, 0));
try
    %% Create data link
    server = StreamSensorDataReader(3400);
    % Makes sure to resources are returned.
    sentinel = onCleanup(@() server.stop());

    server.start();  % Start data reception.

    % Used for visualization.
    figure(1);
    subplot(1, 2, 1);
    ownView = OrientationView('Own filter', gca);  % Used for visualization.
    googleView = [];
    counter = 0;  % Used to throttle the displayed frame rate.

    %% Filter loop
    while server.status()  % Repeat while data is available
        % Get the next measurement set, assume all measurements
        % within the next 5 ms are concurrent (suitable for sampling
        % in 100Hz).
        data = server.getNext(5);

        if isnan(data(1))  % No new data received
            continue;        % Skips the rest of the look
        end
        t = data(1)/1000;  % Extract current time

        if isempty(t0)  % Initialize t0
            t0 = t;
        end



        % Prediction step using gyro data
        gyr = data(1, 5:7)';
        if ~any(isnan(gyr))  % Gyro measurements are available.
            [x, P] = tu_qw(x, P, gyr-bias_gyr, T, Rw);
            gyrOld = gyr;
        else
            [x, P] = tu_qw(x, P, gyrOld, T, Rw);
        end


        
        % Update step using acc data
        acc = data(1, 2:4)';

        % Outlier acc measurements are removed
        accLength = abs( sqrt(acc(1)^2 + acc(2)^2 + acc(3)^2));
        accExpected = 9.82;
        tol = 0.2;
        if accLength - accExpected < tol
            accReliable = acc;
        else
            accReliable = [NaN; NaN; NaN];
        end

        % Acc measurement update
        if ~any(isnan(accReliable)) % Acc measurements are available.
            [x, P] = mu_g(x, P, accReliable-bias_acc, T, Ra);
            setAccDist(ownView,false);
        else
            setAccDist(ownView,true);
        end

        mag = data(1, 8:10)';
        % Outlier acc measurements are removed
       
        magLength = abs( sqrt(mag(1)^2 + mag(2)^2 + mag(3)^2));
        magExpected = (1-alpha)*magExpected + alpha*magLength;
        if magLength - magExpected < magTol
            magReliable = mag;
        else
            magReliable = [NaN; NaN; NaN];
        end
        if ~any(isnan(magReliable))  % Mag measurements are available.
            [x, P] = mu_m(x, P, magReliable, m0, Rm);
        end

        orientation = data(1, 18:21)';  % Google's orientation estimate.

        % Visualize result
        if rem(counter, 10) == 0
            setOrientation(ownView, x(1:4));
            title(ownView, 'OWN', 'FontSize', 16);
            if ~any(isnan(orientation))
                if isempty(googleView)
                    subplot(1, 2, 2);
                    % Used for visualization.
                    googleView = OrientationView('Google filter', gca);
                end
                setOrientation(googleView, orientation);
                title(googleView, 'GOOGLE', 'FontSize', 16);
            end
        end

        counter = counter + 1;

        % Save estimates
        xhat.x(:, end+1) = x;
        xhat.P(:, :, end+1) = P;
        xhat.t(end+1) = t - t0;

        meas.t(end+1) = t - t0;
        meas.acc(:, end+1) = acc;
        meas.gyr(:, end+1) = gyr;
        meas.mag(:, end+1) = mag;
        meas.orient(:, end+1) = orientation;

        assignin('base', 'xhat', xhat);
        assignin('base', 'meas', meas);
    end
catch e
    fprintf(['Unsuccessful connecting to client!\n' ...
        'Make sure to start streaming from the phone *after*'...
        'running this function!']);
end
end

%<<<<<<< HEAD
% Save streamed data to file
% save("data","xhat", "meas");
%=======
%% Save plotted data to file
% save("data","xhat", "meas")
%>>>>>>> 9456df6 (plotting update task2)
