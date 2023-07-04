A = diag([-1,-2,-3]); B = [1;-1;1]; C = [0,1,0]; D = 0;
continuo = ss(A,B,C,D);
Ts = 0.01;
discreto = c2d(continuo,Ts);
A = discreto.a; B = discreto.b; C = discreto.c;

G = eye(3);
H = zeros(1,3);
planta = ss(A,[B,G],C,[D,H],Ts);
Q = 1e-5*eye(3); R = 1e-2;
[estimador,K,P] = kalman(planta,Q,R)

t = 0:0.01:10; u = sin(t);
[y,t,x] = lsim(discreto,u,t,[0.3;0.5;0.7]);
y = y + 0.1*randn(size(y));
[yest,t] = lsim(estimador,[u;y'],t);
yhat = yest(:,1); xhat = yest(:,2:end);
subplot(121); plot(t,y,t,yhat,'LineWidth',1)
subplot(122); plot(t,x,'--',t,xhat,'LineWidth',1)