% --- Operadores aritméticos (predicados simples) ---
precio_con_impuestos(PrecioBase, Impuesto, Total) :- Total is PrecioBase + Impuesto.
precio_con_descuento(PrecioBase, Descuento, Final) :- Final is PrecioBase - Descuento.
costo_total(Copias, PrecioUnitario, Total) :- Total is Copias * PrecioUnitario.
costo_por_persona(Total, Personas, Costo) :- Costo is Total / Personas.
divisible_por_5(Stock) :- 0 is Stock mod 5.
area_estante(Lado, Area) :- Area is Lado * Lado.        % o: Area is Lado ** 2.
es_par(N) :- 0 is N mod 2.

% --- Operadores de comparación ---
es_caro(Precio) :- Precio > 50.
es_barato(Precio) :- Precio < 30.
apto_promocion(Stock) :- Stock >= 10.
bajo_stock(Stock) :- Stock =< 5.
precio_correcto(Precio, Base, Imp) :- Precio =:= Base + Imp.
precios_distintos(Precio1, Precio2) :- Precio1 =\= Precio2.

stock(el_principito, 10).
stock(harry_potter, 3).

precio(el_principito, 60).
precio(harry_potter, 45).

pelicula(inception, ficcion).
pelicula(gump, drama).

% --- Reglas que combinan hechos con condiciones ---
% Operador Y
libro_disponible_caro(Titulo, Precio, Stock) :-
    stock(Titulo, Stock),
    Precio > 50.

% Operador O
clasificar_libro(Precio, Categoria) :- Precio > 50, Categoria = caro.
clasificar_libro(Precio, Categoria) :- Precio =< 50, Categoria = economico.

generos_diferentes(T1, T2) :-
    pelicula(T1, G1),
    pelicula(T2, G2),
    G1 \= G2.

% Negación por fallo
sin_stock(Titulo) :- \+ stock(Titulo, _).

% Regla con aritmética y control de stock
precio_final(Titulo, Copias, Total) :-
    precio(Titulo, Precio),
    stock(Titulo, Stock),
    Stock >= Copias,
    Total is Precio * Copias.

% Si no hay registro de stock, no disponible
precio_final(Titulo, _Copias, no_disponible) :-
    \+ stock(Titulo, _).

