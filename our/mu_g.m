function [x, P] = mu_g(x, P, yacc, T, Rw)

    % Input
    % x: predicted quaternion
    % P: prediction covariance matrix
    % omega: Input gyro values
    % T: time step
    % Rw: noise covariance matrix
    
    % Output:
    % x: updated (posterior) quaternion
    % P: updated (posterior) covariance matrix
    
    % % Mean of accelerometer data when the phone is laying on a table with the screen up
    % g1 = 0.0728;
    % g2 = -0.0770;
    % g3 = 9.8574;
    % 
    % % Force acting on the phone resulting in an acceleration
    % f1 = 0;
    % f2 = 0;
    % f3=  0;
    % 
    % x1 = x(1);
    % x2 = x(2);
    % x3 = x(3);
    % x4 = x(4);
    % 
    % 
    % % How to calculate H:
    % % syms q [4 1]
    % % syms g [3 1]
    % % syms f [3 1]
    % % yacc_syms = Qq(q).'*(g + f);
    % % H = jacobian(yacc_syms, q)
    % 
    % 
    % H = [4*x1*(f1 + g1) + 2*x4*(f2 + g2) - 2*x3*(f3 + g3), 4*x2*(f1 + g1) + 2*x3*(f2 + g2) + 2*x4*(f3 + g3),                  2*x2*(f2 + g2) - 2*x1*(f3 + g3),                  2*x1*(f2 + g2) + 2*x2*(f3 + g3);
    %      4*x1*(f2 + g2) - 2*x4*(f1 + g1) + 2*x2*(f3 + g3),                  2*x3*(f1 + g1) + 2*x1*(f3 + g3), 2*x2*(f1 + g1) + 4*x3*(f2 + g2) + 2*x4*(f3 + g3),                  2*x3*(f3 + g3) - 2*x1*(f1 + g1);
    %      2*x3*(f1 + g1) - 2*x2*(f2 + g2) + 4*x1*(f3 + g3),                  2*x4*(f1 + g1) - 2*x1*(f2 + g2),                  2*x1*(f1 + g1) + 2*x4*(f2 + g2), 2*x2*(f1 + g1) + 2*x3*(f2 + g2) + 4*x4*(f3 + g3)];
    % 
    % 
    % S = H*P*H.' + Rw;
    % K = P*H.'/S;
    % 
    % yacc_hat = Qq(x).'*(g_0 + fak);
    % x = x + K*(yacc - yacc_hat);
    % P = P-K*S*K.';
    x = x;
    P = P;

end