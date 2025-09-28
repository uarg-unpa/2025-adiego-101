:- dynamic lista/2.
cargar_hechos([]).
cargar_hechos([H|T]) :- assertz(H), cargar_hechos(T).
