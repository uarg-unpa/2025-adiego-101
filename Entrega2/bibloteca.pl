% tercero Declarar predicados dinámicos
:- dynamic libro/2.
:- dynamic prestado/2.


libro("el_principito", "antoine_de_saint_exupery").
libro("1984", "george_orwell").
prestado("el_principito", "juan").

% Regla: Un libro está disponible si no está prestado
disponible(Titulo) :- libro(Titulo, _), \+ prestado(Titulo, _).

% Procedimiento para agregar un libro nuevo (al final)
agregar_libro(Titulo, Autor) :- assertz(libro(Titulo, Autor)).

% Procedimiento para agregar un libro nuevo (al inicio)
agregar_libro_al_inicio(Titulo, Autor) :- asserta(libro(Titulo, Autor)).

% Procedimiento para registrar un préstamo
prestar(Titulo, Persona) :- 
    disponible(Titulo), 
    assertz(prestado(Titulo, Persona)).

% Consulta para ver todos los libros
listar_libros :- 
    libro(Titulo, Autor), 
    write('Libro: '), write(Titulo), write(', Autor: '), write(Autor), nl,
    fail.  % Fuerza backtracking para listar todos
listar_libros.  % Clausula vacía para terminar

eliminar_libro(Titulo) :- 
libro(Titulo, _),
\+ prestado(Titulo, _),
retract(libro(Titulo, _)),
write('Libro eliminado: '), write(Titulo), nl.
eliminar_libro(Titulo) :-
prestado(Titulo, _),
write('Error: Libro '), write(Titulo), write(' está prestado.'), nl,
fail. % Fuerza fracaso si está prestado
eliminar_libro(Titulo) :-
\+ libro(Titulo, _),
write('Error: Libro '), write(Titulo), write(' no existe.'), nl,
fail. % Fuerza fracaso si no existe

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% Parte 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
%% Al ejecutar ?- eliminar_libro("1984"). ejecuta la primera cabeza que elimna el libro y luego busca nuevamente si existe el libre, al no existir, termina la ejecucion.
%% Libro eliminado: 1984
%% true ;
%% Error: Libro 1984 no existe.
%% false.
%% 
%% ?- eliminar_libro("el_principito").
%% Error: Libro el_principito está prestado.
%% false.

% --- Adicional: eliminar_prestamo/1
% Elimina el préstamo si existe; si no, falla con mensaje.


eliminar_prestamo(Titulo) :-
    prestado(Titulo, Persona),
    retract(prestado(Titulo, Persona)),
    write('Se eliminó el préstamo de "'), write(Titulo), write('" a '), write(Persona), write('.'), nl, !.
eliminar_prestamo(Titulo) :-
    write('No hay préstamo registrado para "'), write(Titulo), write('".'), nl,
    fail.

%?- eliminar_prestamo("el_principito").
%Se eliminó el préstamo de "el_principito" a juan.
%true.
%
%?- eliminar_libro("el_principito").
%Libro eliminado: el_principito
%true ;
%Error: Libro el_principito no existe.
%false.

producto(laptop, 800). % producto(Nombre, Precio)
producto(celular, 300).
producto(tablet, 150).

clasificar(Producto, Categoria) :-
producto(Producto, Precio),
Precio > 500,
Categoria = caro,
!. % Cut: No backtrack si caro
clasificar(Producto, Categoria) :-
producto(Producto, Precio),
Precio >= 200, Precio =< 500,
Categoria = medio,
!. % Cut: No backtrack si medio
clasificar(Producto, Categoria) :-
producto(Producto, Precio),
Precio < 200,
Categoria = barato.