function [x, P] = mu_g(x, P, yacc, T, Rw)
    
    % Input
    % x: predicted quaternion
    % P: prediction covariance matrix
    % yacc: Input accelerometer values
    % T: time step
    % Rw: noise covariance matrix
    
    % Output:
    % x: updated (posterior) quaternion
    % P: updated (posterior) covariance matrix
    
    % % Mean of accelerometer data when the phone is laying on a table with the screen up
  
    g = [0.0728; -0.0770; 9.8574];
    % 
    % % Force acting on the phone resulting in an acceleration
    f = [0; 0; 0] ;

    
  
    % 
    % 
    % % How to calculate offline H and Qq_transpose:
    % % syms q [4 1]
    % % syms g [3 1]
    % % syms f [3 1]
    % % Qq_transpose = Qq(q).'
    % % yacc_syms = Qq(q).'*(g + f);
    % % H = jacobian(yacc_syms, q)
    % 

    H = [4*x(1)*(f(1) + g(1)) + 2*x(4)*(f(2) + g(2)) - 2*x(3)*(f(3) + g(3)), 4*x(2)*(f(1) + g(1)) + 2*x(3)*(f(2) + g(2)) + 2*x(4)*(f(3) + g(3)),                  2*x(2)*(f(2) + g(2)) - 2*x(1)*(f(3) + g(3)),                  2*x(1)*(f(2) + g(2)) + 2*x(2)*(f(3) + g(3));
         4*x(1)*(f(2) + g(2)) - 2*x(4)*(f(1) + g(1)) + 2*x(2)*(f(3) + g(3)),                  2*x(3)*(f(1) + g(1)) + 2*x(1)*(f(3) + g(3)), 2*x(2)*(f(1) + g(1)) + 4*x(3)*(f(2) + g(2)) + 2*x(4)*(f(3) + g(3)),                  2*x(3)*(f(3) + g(3)) - 2*x(1)*(f(1) + g(1));
         2*x(3)*(f(1) + g(1)) - 2*x(2)*(f(2) + g(2)) + 4*x(1)*(f(3) + g(3)),                  2*x(4)*(f(1) + g(1)) - 2*x(1)*(f(2) + g(2)),                  2*x(1)*(f(1) + g(1)) + 2*x(4)*(f(2) + g(2)), 2*x(2)*(f(1) + g(1)) + 2*x(3)*(f(2) + g(2)) + 4*x(4)*(f(3) + g(3))];
 

    Qq_transpose = [2*x(1)^2 + 2*x(2)^2 - 1,    2*x(1)*x(4) + 2*x(2)*x(3),  2*x(2)*x(4) - 2*x(1)*x(3);
                    2*x(2)*x(3) - 2*x(1)*x(4),  2*x(1)^2 + 2*x(3)^2 - 1,    2*x(1)*x(2) + 2*x(3)*x(4);
                    2*x(1)*x(3) + 2*x(2)*x(4),  2*x(3)*x(4) - 2*x(1)*x(2),  2*x(1)^2 + 2*x(4)^2 - 1];
    S = H*P*H.' + Rw;
    K = (P*H.')/S;
    
    yacc_hat = Qq_transpose*(g + f);
    x = x + K*(yacc - yacc_hat);
    P = P-K*S*K.';
    [x, P] = mu_normalizeQ(x, P);
    %x = x;
    %P = P;
