# Capitulo 8 - Solucoes numericas de equacoes diferenciais ordinarias - (1) PVC

function projcap81
  a = 0;               #inicio do intervalo  
  b = 2;               #final do intervalo (intervalo melhor com b=1)
  h1 = 0.5;
  h2 = 0.25;
  h3 = 0.1;
  h4 = 0.01;
  
  aplica_coefs(h1, a, b);
  aplica_coefs(h2, a, b);
  aplica_coefs(h3, a, b);
  aplica_coefs(h4, a, b);
endfunction

function aplica_coefs(h, a, b)
  #dada uma equacao discretizada na forma '(1-h)y [i-2] +((h^2)-2)y [i-1] = (i-1)h^3 +(h+1)', 
  #seus coeficientes em funcao de h são:
  c1 = (1 - h);
  c2 = (h^2 - 2);
  c3 = (h + 1);
  sol = (h^3);
  
  s_numerica = inline("2*(e^(-x))*(1-x)+(x-2)");   #solucao numerica conhecida
  
  #pontos dados, se nao houver marcar NULL
  p1 = [0,0];
  p2 = [1,-1];
  
  intervalos = ((b-a)/h)-1;   #numero de intervalos
  
  y = pvc(h, c1, c2, c3, sol, intervalos);
  
  printf("Valores encontrados para h = %.2f, X, Y analitico, Y numerico e a diferença respectivamente:\n", h);
  
  for i = 1:intervalos    #calcula solucao numerica e x
    x(i) = i*h;
    vet(i) = s_numerica(i*h);
  endfor
  
  for i = 1:intervalos    #mostra tabela x y  
    printf("%.4f %.4f %.4f %.4f\n", i*h, y(i), vet(i), ((vet(i)-y(i))^2)^(1/2));
  endfor
  
  grafico(x, y, vet);

endfunction
  
  
  
function y = pvc(h, c1, c2, c3, sol, intervalos)
  #monta matriz com coeficientes
  u = c1*ones(intervalos-1,1);
  v = c2*ones(intervalos,1);   #diagonal principal
  w = c3*ones(intervalos-1,1);
  
  A = diag(u,-1);
  B = diag(v);
  C = diag(w,1);
  
  Matriz = A+B+C;
  
  b(1) = sol;   #primeira posicao
  for i = 2:intervalos-1;
    b(i) = i*sol;
  endfor
  b(intervalos) = (intervalos)*sol+h+1;   #ultima posicao
  
  b = b';    #transpoe b
  
  #resolve sistema
  y = Matriz\b;
  
endfunction



function grafico(x, y, vet)
  #gera grafico

  xlabel('X');
  ylabel('Y'); 
  plot(x,y',"ro",x,y',"b-;Analitica;");
  hold on;
  grid on;
  plot(x,vet,"ro",x,vet,"k-;Numerica;");
  hold off;     #gera para todos os hs, mas so mantem o 0.01
  
endfunction
