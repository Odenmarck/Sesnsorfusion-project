function delta_q = delta_angle_q(q, q_hat) % Calculates angle between two unit quaternions
n = 4;
delta_q = 0;
for i = 1:n
    delta_q = delta_q + q(i)*q_hat(i);
end
delta_q = 2 * acos(delta_q);

