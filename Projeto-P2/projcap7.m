# Capitulo 7 - Integracao numerica - (2) Regra 1/3 de Simpson repetida

function [y2,y4,y8,y10] = projcap7(a,b,func)
	#chamada do tipo: [y2,y4,y8,y10] = projcap7(0,3,'(x^3)')

	#calculo dos h para as diferentes subdivisoes
    h2 = (b-a)/2;
    x2 = a:((b-a)/2):b;
    
    h4 = (b-a)/4;
    x4 = a:((b-a)/4):b;
    
    h8 = (b-a)/8;
    x8 = a:((b-a)/8):b;
    
    h10 = (b-a)/10;
    x10 = a:((b-a)/10):b;

    func = inline(func);
    
    #calculo dos fx
    for i2 = 1:length(x2)
        fx2(i2) = func(x2(i2));
    endfor

    for i4 = 1:length(x4)
        fx4(i4) = func(x4(i4));
    endfor
    

    for i8 = 1:length(x8)
        fx8(i8) = func(x8(i8));
    endfor
    

    for i10 = 1:length(x10)
        fx10(i10) = func(x10(i10));
    endfor
    
    #calculo dos somatorios de y
    y2 = fx2(1)+fx2(length(x2));
    for i2= 2:length(x2)-1
        if mod(i2,2) == 0
            y2 += 4*fx2(i2); 
        else
            y2 += 2*fx2(i2);   
        endif 
    endfor
    
        y4 = fx4(1)+fx4(length(x4));
    for i4 = 2:length(x4)-1
        if mod(i4,2) == 0
            y4 += 4*fx4(i4); 
        else
            y4 += 2*fx4(i4);   
        endif 
    endfor
    
          y8 = fx8(1)+fx8(length(x8));
    for i8 = 2:length(x8)-1
        if mod(i8,2) == 0
            y8 += 4*fx8(i8); 
        else
            y8 += 2*fx8(i8);   
        endif 
    endfor
    
          y10 = fx10(1)+fx10(length(x10));
    for i10 = 2:length(x10)-1
        if mod(i10,2) == 0
            y10 += 4*fx10(i10); 
        else
            y10 += 2*fx10(i10);   
        endif 
    endfor
    
    #calculo da integracao exata
    [v, ier, nfun, err] = quad(func, a, b);
    printf("O valor exato da integração é:")
    disp(v);
    printf("O valor da aproximação para 2, 4, 8 e 10 subdivisões é, respectivamente: \n")
    
    #multiplicacao dos h pelos y para finalizar o calculo da aproximacao
    y2 = h2/3*y2;
    y4 = h4/3*y4;
    y8 = h8/3*y8;
    y10 = h10/3*y10;

endfunction