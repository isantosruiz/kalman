function [xhat,Pnew] = filtrar(y,x,P,Q,R)
xhat = (R*x + P*y)/(R + P);
Pnew = P*R/(P + R) + Q;