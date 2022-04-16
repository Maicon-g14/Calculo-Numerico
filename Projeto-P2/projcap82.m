# Capıtulo 8 - Solucoes numericas de equacoes diferenciais ordinarias - (2) Metodo de previsao-correcao

function projcap82
  h1 = 0.5;
  h2 = 0.01;
  precisao = 0.0001;   #precisao 10^5
  
  funcao = input("Insira a expressao na forma '@(x,y) expressao' ex: @(x,y) 2*x+1:\n");
  xi = input("Insira o valor de X de um ponto: ");
  yi = input("Insira o valor de Y correspondente: ");
  
  #chamada das funcoes
  [x, y] = main(funcao, h1, xi, yi, precisao);
  impressao(h1, x, y);
  
  #[x2, y2] = main(funcao, h2, xi, yi, precisao);
  #impressao(h2, x2, y2);
  
endfunction



function [x,y] = main(funcao, h, xi, yi, precisao)
  ponto(1,1) = xi;    #atribui ponto dado a lista de pontos
  ponto(2,1) = yi;
  
  for i = 1 : 1 : 4   #aplica RK aos 4 primeiros
    y = runge_kutta(funcao, h, xi+(i*h)-h, yi);
    
    ponto(1,i+1) = xi+(i*h);    #salva ponto x
    ponto(2,i+1) = y;    #salva ponto y
    yi = y;
    
  endfor
  
  for i = 1 : 1 : 2   #aplica AB aos prox 6
    [y,L] = previsor(funcao, h, ponto);
    
    ponto(1,4+i) = ponto(1,4+i-1) + h;
    ponto(2,4+i) = y;
  
  endfor
  
  x = ponto(1, length(ponto));
  y = ponto(2, length(ponto));
  
  while(erro_eh_maior(y,yi,precisao))   #aplica corretor enquanto precisao nao for atingida
    yi = y;
    y = corretor(funcao, ponto, h, L);
    
  endwhile
  
  printf("Sejam as linhas X e Y e, as colunas numeradas de 0 a 10:\n")
  ponto

endfunction



function y = runge_kutta(funcao, h, xi, yi)
  # calcula runge kutta de ordem 3
  k1 = h * funcao(xi, yi);
  k2 = h * funcao(xi + h/2, yi + k1/2);
  k3 = h * funcao(xi + ((3*h)/4), yi + ((3*k2)/4));
  
  y = yi + (2/9)*k1 + (3/9)*k2 + (4/9)*k3;
  
endfunction



function [y,L] = previsor(funcao, h, ponto)
  #Calcula previsor pelo metodo de Adams-Bashforth
  for i = 0 : 1 : 3   #Calcula 4 pontos e salva num vetor
    L(i+1) = funcao(ponto(1,length(ponto)-i), ponto(2,length(ponto)-i));
  endfor
  L(1)
  ponto
  y = ponto(2,length(ponto)) + (h/24)*(55*L(1) - 59*L(2) + 37*L(3) - 9*L(4));

endfunction



function y = corretor(funcao, ponto, h, L)
  #Calcula corretor pelo metodo de Adams-Moulton 
  for i = 4 : -1 : 2    #move as posicoes do vetor liberando espaco pra calcular o L da ultima posicao
    L(i) = L(i-1);
  endfor
  L
  L(1) = funcao(ponto(1,length(ponto)), ponto(2,length(ponto)));    #Calcula L do ultimo ponto encontrado
  L
  y = ponto(2,length(ponto)-1) + (h/24)*(9*L(1) + 19*L(2) - 5*L(3) + L(4));

endfunction



function continua = erro_eh_maior(y, yi, precisao)
  #Verifica precisao do valor comparando y e yi, se ja tiver atingido precisao buscada retorna 0
  errop = (y - yi);
  
  errop = modulo(errop);
  y = modulo(y);
  
  erro = errop / y;
  
  continua = 1;
  
  if (erro < precisao)
    continua = 0;
  endif
  
endfunction



function saida = modulo(numero)
  #Retorna modulo de um numero
  saida = numero;

  if (numero < 0)
    saida *= -1;
  endif

endfunction


function impressao(h, x, y)
  #Mostra x10 e y10 obtidos pelo metodo
  printf("Para [h = %.2f]: (x10,y10) = (%.5f,%.5f)\n", h, x, y);
  
endfunction
