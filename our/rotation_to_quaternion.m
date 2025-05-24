function q = rotation_to_quaternion(rotation_mat)
    q0 = 1/2 * sqrt(sum(diag(rotation_mat) + 1));
    q = [q0; 
        (rotation_mat(2,3) - rotation_mat(3, 2))/(4*q0);
        (rotation_mat(3,1) - rotation_mat(1,3))/(4*q0);
        (rotation_mat(1,2)- rotation_mat(2,1))/(4*q0)];
    q = q/norm(q);  %unit quaternion
    q = double(q);
    
end