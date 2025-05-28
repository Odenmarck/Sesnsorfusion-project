function [x, P] = tu_qw(x, P, omega, T, Rw)

% Performs time update step
% x: quaternion
% P: covariance matrix
% omega: Input gyro values
% T: time step
% Rw: noise covariance matrix
F = @(w) T/2 * Somega(w) + eye(4);
G = @(q) T/2 * Sq(q);

%Motion_model = @(w, q, cov) F(omega)*x + G(x)*mvnrnd(zeros(3,1), Rw).';

x = F(omega)*x; %update x
P = F(omega)*P*F(omega).' + G(x)*Rw*G(x).';
[x, P] = mu_normalizeQ(x, P); %Normalizing quaternion








 
