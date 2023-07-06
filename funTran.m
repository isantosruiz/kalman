function xnext = funTran(x,u)
m = 1; l = 0.5; g = 9.8;
xnext = x + 0.01*[x(2);1/(m*l^2)*u-g/l*sin(x(1))];