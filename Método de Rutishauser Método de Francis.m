clear all
clc
matriz = 10*rand(3,3)
matriz = round(matriz)
A = matriz
boolean = true
contador = 1
tolerancia = 10**-2

if det(A) != 0
  % Método de Rutishauser
  while boolean != false && contador < 10
    U = A
    L = eye(length(A),length(A))
    pivor = 1
    while pivor <= length(U)
      for i=pivor+1:length(U)
        multiplicador = U(i,pivor)/U(pivor,pivor)
        L(i,pivor) = multiplicador
        for j=1:length(U)
          U(i,j) -= multiplicador*U(pivor,j)
        endfor
      endfor
      pivor += 1
    endwhile

    A = U*L
    boolean = false
    for j=1:length(A)
      for i=j+1:length(A)
        if A(i,j) > tolerancia
            boolean = true
        endif
      endfor
    endfor
    contador += 1
  endwhile
  input()
  auto_valores_Rutishauser = sort(diag(A))

  % Método de Francis
  A = matriz
  boolean = true
  contador = 1
  while boolean != false && contador < 3
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
    contador += 1
  endwhile

  if auto_valores_Rutishauser(1) > auto_valores_Rutishauser(end)
    auto_valores_Rutishauser = fliplr(auto_valores_Rutishauser)
  endif

  auto_valores_Francis = sort(diag(A))
  if auto_valores_Francis(1) > auto_valores_Francis(end)
    auto_valores_Francis = fliplr(auto_valores_Francis)
  endif

  auto_valores_de_A = sort(eig(matriz))
  if auto_valores_de_A(1) > auto_valores_de_A(end)
    auto_valores_de_A = fliplr(auto_valores_de_A)
  endif

  aux1 = 0
  for i=1:length(auto_valores_de_A)
    aux1 += abs(auto_valores_de_A(i)) - abs(auto_valores_Rutishauser(i))
  endfor
  aux2 = 0
  for i=1:length(auto_valores_de_A)
    aux2 += abs(auto_valores_de_A(i)) - abs(auto_valores_Francis(i))
  endfor
  aux1 = abs(aux1)
  aux2 = abs(aux2)
  if aux1 < aux2
    melhor = 'Rutishauser convergiu melhor que o de Francis.'
  else
    if aux1 > aux2
      melhor = 'Francis convergiu melhor que o de Rutishauser.'
    else
      melhor = 'Ambos convergiram igualmente.'
    endif
  endif
endif

A = matriz
clc
A
auto_valores_de_A
printf('\n')
melhor
printf('\n')
auto_valores_Rutishauser
auto_valores_Francis
