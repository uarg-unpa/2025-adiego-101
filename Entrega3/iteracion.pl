%%Parte 3: Iteración con random e Impresión Recursiva

%%mplementa un predicado recursivo para 
%%imprimir N números aleatorios entre 1 y 100,
%%usando iteración recursiva

%%Cuando queda solo un número por imprimir, el predicado genera un aleatorio, 
%%lo escribe en pantalla y después imprime el mensaje "fin". 
%%El corte (!) asegura que no se sigan buscando más soluciones.

imprimir(1) :-
random(1, 100, A), % Genera un número aleatorio entre 1 y 100
write(A), nl, % Lo muestra en pantalla
write('fin'), nl, % Mensaje de fin
!. % Cut para cortar al final
imprimir(X) :-
X > 1,
random(1, 100, A),
write(A), nl,
X1 is X - 1,
imprimir(X1).

%tabla10(N):- tabla(N,1).
% Caso base: cuando ya se llegó a multiplicar hasta 10
tabla(N, 10) :-
    R is N * 10,
    write(N), write(' * 10 = '), write(R), nl,
    !.

% Caso recursivo: multiplica hasta M, luego avanza
tabla(N, M) :-
    M < 10,
    R is N * M,
    write(N), write(' * '), write(M), write(' = '), write(R), nl,
    M1 is M + 1,
    tabla(N, M1).


%%Parte 4: Actualización con recursividad de una Base de Conocimiento

%%Se desea gestionar el precio de productos de un supermercado. 
%%Cada producto tiene un nombre, un precio y una categoría.
:- dynamic producto/3.

% producto(Nombre, Precio, Categoria).
producto(manzana, 100, f).
producto(peras,   150, f).
producto(leche,   200, e).
producto(pan,     120, e).
producto(lechuga, 80,  v).
producto(yerba,   500, e).

% Aumenta 5% todos los de categoria 'e'
aumento_productos :-
    producto(Nombre, Precio, e),
    retract(producto(Nombre, Precio, e)),
    NuevoPrecio is Precio * 1.05,
    assertz(producto(Nombre, NuevoPrecio, e)),
    write('Producto: '), write(Nombre),
    write(', Nuevo Precio: '), write(NuevoPrecio),
    write(', Categoria: e'), nl,
    fail.  % fuerza backtracking para procesar todos
aumento_productos.  % caso base: termina en true

