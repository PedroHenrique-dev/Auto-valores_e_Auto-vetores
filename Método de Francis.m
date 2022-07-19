% Método de Francis
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
while boolean != false
  [Q,R] = qr(A)
  A = R*Q
  boolean = false
  for j=1:length(A)
    for i=j+1:length(A)
      if A(i,j) > tolerancia
          boolean = true
      endif
    endfor
  endfor
endwhile

auto_valores = diag(A)
