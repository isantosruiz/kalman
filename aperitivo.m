A = diag([-1,-2,-3]); B = [1;-1;1]; C = [0,1,0]; 
continuo = ss(A,B,C,0);
discreto = c2d(continuo,0.01);
A = discreto.a; B = discreto.b; C = discreto.c;
%------------------------------------------------
t = 0:0.01:10;
u = sin(t);
[y,t,x] = lsim(discreto,u,t,[0.3;0.5;0.7]);
y = y + 0.1*randn(size(y));
%------------------------------------------------
kf = KalmanFilter(A,B,C,eye(3)*1e-6,0.01);
xhat = kf.estimate(u,y');
yhat = C*xhat;
subplot(211); plot(t,y,t,yhat,'Linewidth',1)
subplot(212); plot(t,xhat,t,x,'--','LineWidth',1)
