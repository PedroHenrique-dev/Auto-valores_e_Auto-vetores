% Método da Potência Inversa
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
  U = A
  L = eye(length(A),length(A))
  pivor = 1
  while pivor < length(U)
    for i=pivor+1:length(U)
      multiplicador = U(i,pivor)/U(pivor,pivor)
      L(i,pivor) = multiplicador
      for j=1:length(U)
        U(i,j) -= multiplicador*U(pivor,j)
      endfor
    endfor
    pivor += 1
  endwhile

  erro = 1
  erroVetor = []
  lambda = []
  contador = 1

  y = linspace(1,1,length(A))
  y = y'
  delta = L\y
  z = U\delta
  while erro > tolerancia
    alpha = max(abs(z))
    y = (alpha**-1)*z
    delta = L\y
    z = U\delta
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
eig(A)
menor_autovalor = 1/lambda(local)
auto_vetor_do_menor_autovalor = y
