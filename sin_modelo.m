t = 0:0.01:10;
y = sin(t) + 0.1*randn(size(t));
kf = KalmanFilter(1,0,1,0.01,1);
ykalman = kf.estimate(zeros(size(t)),y);
p = plot(t,y,t,ykalman);
p(2).LineWidth = 1;