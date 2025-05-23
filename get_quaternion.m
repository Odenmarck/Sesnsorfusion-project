function q = get_quaternion(alpha, v)
    % alpha: Angle of rotation
    % v: axis of rotation
    v_hat = v/norm(v);
    q = [cos(1/2 * alpha);
        sin(1/2*alpha) * v_hat];
    q = q/norm(q); % Unit quaternion
end