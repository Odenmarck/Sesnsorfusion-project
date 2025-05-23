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

q_replica = rotation_to_quaternion(R_W_to_S)