% Deflação de Hotteling
clear all
clc

linhas = input('Insira a quantidade de linhas: ')
colunas = input('Insira a quantidade de colunas: ')

A = zeros(linhas, colunas)

menu = 1
while menu != 0
  clc
  A
  printf('\n  * MENU\n')
  printf('1. Alterar\n')
  printf('0. Continuar\n\n')
  menu = input('Escolha a opção: ')
  if menu == 1
    printf('\n')
    alterarLinha = input('Escolha a linha: ')
    printf('\n')
    alterarColuna = input('Ecolha a coluna: ')
    printf('\n')
    A(alterarLinha, alterarColuna) = input('Digite o valor: ')
  endif
endwhile

clc
tolerancia = input('Insira o valor da tolerancia: ')
if det(A) != 0
  y = linspace(1,1,length(A))
  y = y'
  erro = inf
  erroVetor = []
  lambda = []
  contador = 1
  z = A*y
  while erro > tolerancia
    alpha = max(abs(z))
    y = (alpha**-1)*z
    z = A*y
    for i=1:length(z)
      lambda(end+1)=z(i)/y(i)
    endfor
    if contador > 1
      erroVetor = []
      for i=0:length(z)-1
        erroVetor(end+1) = abs(lambda(2*length(A)-i) - lambda(length(A)-i))/abs(lambda(2*length(A)-i))
      endfor
      erro = min(erroVetor)
      lambda(1:length(A)) = []
    endif
    contador += 1
  endwhile

  erroVetor = fliplr(erroVetor)
  for i=1:length(erroVetor)
    if erro == erroVetor(i)
      local = i
    endif
  endfor

  primeiro_maior_autovalor = lambda(local)
  autovetor_do_primeiro_maior_autovalor = y

  erro = inf
  erroVetor = []
  lambda = []
  contador = 1

  x = y/norm(y)**2
  B = A*(eye(length(A))-y*x')
  y = linspace(1,1,length(A))
  y = y'
  z = B*y
  while erro > tolerancia
    alpha = max(abs(z))
    y = (alpha**-1)*z
    z = B*y
    for i=1:length(z)
      lambda(end+1)=z(i)/y(i)
    endfor
    if contador > 1
      erroVetor = []
      for i=0:length(z)-1
        erroVetor(end+1) = abs(lambda(2*length(A)-i) - lambda(length(A)-i))/abs(lambda(2*length(A)-i))
      endfor
      erro = min(erroVetor)
      lambda(1:length(A)) = []
    endif
    contador += 1
  endwhile

  erroVetor = fliplr(erroVetor)
  for i=1:length(erroVetor)
    if erro == erroVetor(i)
      local = i
    endif
  endfor
endif

clc
A
primeiro_maior_autovalor
autovetor_do_primeiro_maior_autovalor
segundo_maior_autovalor = lambda(local)
autovetor_do_segundo_maior_autovalor = y
