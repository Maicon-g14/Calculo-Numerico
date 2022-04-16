# Capitulo 6 - Ajustes de curvas pelo metodo dos quadrados mınimos - (1) Caso discreto

function mmq(t,y)
	#executar nesse formato, inserir coordenadas com abscissas em ordem crescente 
	#mmq([0.1,0.2,0.5,1,1.2,2,2.7,5],[0.4205,0.884,2.5625,6.5,8.544,20,35.2215,132.5])
	#mmq([1.2,1.7,2.3,2.8,4.4,4.9,5.1,5.7],[-11.872,-14.437,-17.383,-18.848,-8.416,2.299,7.901,29.843])

	#define as funcoes gs
	function y=g0(t); y=t.^0; endfunction
	function y=g1(t); y=t; endfunction
	function y=g2(t); y=t.^2; endfunction
	function y=g3(t); y=t.^3; endfunction 
   
	#matriz dos coef do sistema, produto escalar das gs
	A = [
	[ g0(t)*g0(t)', g0(t)*g1(t)', g0(t)*g2(t)',  g0(t)*g3(t)']
	[ g1(t)*g0(t)', g1(t)*g1(t)', g1(t)*g2(t)',  g1(t)*g3(t)']
	[ g2(t)*g0(t)', g2(t)*g1(t)', g2(t)*g2(t)',  g2(t)*g3(t)']
	[ g3(t)*g0(t)', g3(t)*g1(t)', g3(t)*g2(t)',  g3(t)*g3(t)']
	];

	#vetor variavel independete 
	b = [ g0(t)*y'; g1(t)*y'; g2(t)*y' ; g3(t)*y' ];

	#resolve o sistema 
	a = A \ b;

	#transforma matriz coluna em matriz linha
	aux = [a(4,1), a(3,1), a(2,1), a(1,1)];

	#monta o polinomio com o conteudo da matriz linha
	p3 = polyout(aux,'x')

	#mostra o polinomio
	#disp(p3)

	#escreve a funcao do plot
	function y=pol(t); y=a(1,1) + a(2,1)*t + a(3,1)*t.^2 + a(4,1)*t.^3; endfunction;

	#plot do polinomio e dos pontos
	# + para aproximacao e * para os pontos de entrada
	plot(t, pol(t),'-b', t, y,'*k')
   

endfunction
