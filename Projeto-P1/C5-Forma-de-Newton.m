#Grupo 16 - Capitulo 5 - Forma de Newton

function interpol_newton
  X     = [];
  ordem = [];

  qtde = input("Qtde de valores: ");
  
  % Entra com os X's necessarios
  for i = 1 : 1 : qtde
      fprintf("Entre com o valor de X%d ", i);   
      X(i) = input('> ')
  endfor

  % Entra com F(X) necessarios
  for i = 1 : 1 : columns(X)
      fprintf("Entre com o valor de F(X%d) ", i);
      ordem(i,1) = input('> ')
  endfor
  
  % Processa aplicando a formula e guarda resultado em cada coluna da tabela
  for h = 1 : 1 : columns(X)
    for i = 1 : 1 : columns(X)-h
      ordem(i,h+1) = ( ordem(i+1,h) - ordem(i,h) ) / ( X(i+h) - X(i) );
    endfor
  endfor
  
  printf("Cada coluna corresponde a ordem de x0 a x%d, com cada linha correspondendo aos valores de X\n", qtde-1);
  
  ordem
  
endfunction