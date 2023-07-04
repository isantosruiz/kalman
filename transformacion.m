x = randn(1000000,1);
mu_x = mean(x)
sigma2_x = var(x)
y = 3*x+4;
mu_y = mean(y)
sigma2_y = var(y)
histogram(x,100,'Normalization','pdf'); hold on
histogram(y,100,'Normalization','pdf'); hold off