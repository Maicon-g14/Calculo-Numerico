#Grupo 16 - Capitulo 3 - Gauss Jacobi

function gauss_jacobi
  aux_x = []; iteracao = 0;
  
  x = input("Aproximacao inicial(ex: [0 1 2]): ");
  e = input("Precisao (ex: 0.0001): ");
  mat = input("Matriz do sistema (ex: [1 2 3 S1;4 5 6 S2]): ");
  
  if (criterio_das_linhas(mat, x))
    mat = isola_pivo(mat);
    
    while (verifica_precisao(aux_x, x, e))
      iteracao++;
      i = 1;
      
      while (i <= rows(mat))
        soma = 0;
        j = 1;
        
        while (j <= columns(mat)-1)    #nao aplica na ultima pois é a solucao do sistema
        
          if (i != j)   #se nao for o pivo do sistema
            soma += mat(i,j) * x(j);
          
          endif
          j++;
          
        endwhile
        aux_x(i) = (soma + mat(i,j))/sqrt((mat(i,i))^2);    #acrescento a solucao do sist na soma e divido pelo modulo do pivo
        i++;
        
      endwhile
      aux = aux_x;    #guarda novos valores numa auxiliar
      aux_x = x;    #guarda os valores antigos para usar no erro posteriormente
      x = aux;    #define o novo vetor x
      
    endwhile
  else
    printf("nao satisfez o criterio das linhas,\ntente trocar a ordem das linhas da matriz\n");
  
  endif
  printf("Na iteracao %i x= ",iteracao);
  imprime_vetor(x);
    
endfunction




function estado = verifica_precisao(aux_x, x, e)
  # Ao atingir a precisao buscada, retorna o valor 0
  estado = 0; i = 1;
  
  if (columns(aux_x) == 0)
    estado = 1;
    return;
    
  endif
  
  while (i <= columns(aux_x)) 
    if ((sqrt((x(i) - aux_x(i))^2)) > e)    #verifica se modulo das diferencas é maior que o erro
      estado = 1;
      return;
    
    endif
    i++;
    
  endwhile

endfunction




function estado = criterio_das_linhas(mat, x)
  #testa o criterio das linhas
  i = 1; vet = x; estado = 0;
  
  while (i <= rows(mat))    
    j = 1;
    soma = 0;
  
    while (j <= columns(mat)-1)   #ignora a coluna de solucoes do sistema
      if (i != j)   #se nao for o pivo
        soma += sqrt((mat(i,j))^2);   #soma o modulo das posicoes diferentes do pivo
      
      endif
      j++;
      
    endwhile
    vet(i) = (soma/sqrt((mat(i,i))^2));    #faz a divisao pelo modulo do pivo
    i++;
    
  endwhile
  vet = sort(vet);    #ordena o vetor
  
  if (vet(columns(vet)) < 1)    #testa se o maior numero é menor que 1
    estado = 1;
    printf("Satisfaz o critério das linahs com %f < 1\n",vet(columns(vet)));
    return;
    
  endif
  
endfunction




function mat = isola_pivo(mat)
  # Inverte sinal dos termos de uma linha para isolar o pivo na equacao
  i = 1;
  
  while (i <= rows(mat))
    j = 1;
    
    while (j <= columns(mat)-1)
      if (i != j)
        mat(i,j) *= -1;   #inverte o sinal de todos os termos exceto o pivo e a solucao
        
      endif
      j++;
      
    endwhile
    i++;
    
  endwhile
  
endfunction




function imprime_vetor(x)
  i = 1;
  
  printf("[ ");
  while (i <= columns(x))
    printf("%f ", x(i));
    i++;
  
  endwhile
  printf("]\n");
  
endfunction
