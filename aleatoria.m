f = @(x) (x/6).*double(x<3)+(4-x)/2.*double(x>=3);
fplot(f,[0,4])

% Cálculo analítico (aproximado numéricamente)
integral(f,0,4) % ¿Es una PDF?
mu = integral(@(x)x.*f(x),0,4)
sigma2 = integral(@(x)(x-mu).^2.*f(x),0,4)

% Cálculo por fuerza bruta
pdf = makedist('Triangular','A',0,'B',3,'C',4);
x = random(pdf,1000000,1);
mu = mean(x)
sigma2 = var(x)