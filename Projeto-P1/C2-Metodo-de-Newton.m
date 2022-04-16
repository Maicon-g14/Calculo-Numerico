#Grupo 16 - Capitulo 2 - Método de Newton

function newton_rapson
  iteracao = 0;
  
  x = input("Aproximacao inicial (ex: 32): ");
  e = input("Precisao: ");
  y = input("Coeficientes da expressao (ex: p/ 2x^2 + 1 poe-se [2 0 1]): ");
  #y = f(x)
  
  yd = polyder(y);    #deriva y
  aux = e+1;    #condicao de entrada no laco

  while (sqrt(aux^2) > e)
    
    iteracao++;   #conta iteracao
    
    xf = x - (aplica_x(y,x)/aplica_x(yd,x));    #formula de newton
    
    aux = sqrt(xf^2) - sqrt(x^2);   #verifica erro
    
    x = xf;
    
  endwhile

  printf("x%i = %f\n", iteracao, xf);
  
endfunction


function y = aplica_x (mat, x)
  # Dado uma matriz de coeficientes e um numero x,
  # aplica x na matriz interpretando-a como
  # uma equacao de grau = numero de colunas-1 e retorna seu f(x) 
 
  #definicao de variaveis
  y = 0;
  tam = columns(mat);
  expoente = columns(mat)-1;
  i = 1;
  
  while (i <= tam)
    mat(i) *= x^expoente;
    expoente--;
    i++;
  endwhile
  
  i = 1;
  
  while (i <= tam)
    y += mat(i);    #somatorio das posicao da matriz
    i++;
  endwhile
  
endfunction
