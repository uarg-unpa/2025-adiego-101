% Programa para convertir horas a minutos con entrada/salida
% Predicado principal: Lee horas, calcula minutos, imprime resultado
convertir_horas :-
    write('Ingrese la cantidad de horas (numero seguido de punto, ej: 5.): '), nl,
    read(Horas),
    number(Horas),  % Verifica que Horas sea un número
    Minutos is Horas * 60,
    write('Las '), write(Horas), write(' horas equivalen a '), write(Minutos), write(' minutos.'), nl.

% Caso de error si no es número
convertir_horas :-
    write('Error: Debe ingresar un numero valido (ej: 5.). Intente de nuevo.'), nl,
    convertir_horas.  % Reintenta