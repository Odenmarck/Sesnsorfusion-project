function qdot = dt_q(w, q)
%W: Angular Velocity Vector
S=Somega(w); 
qdot = 1/2 * S * q;


