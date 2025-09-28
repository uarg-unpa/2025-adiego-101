%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Ejercicio de Entrega: Conceptos Básicos de Programación Lógica
%% Tema: Películas y Actores
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PARTE 1: HECHOS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a) Inception es una película de ciencia ficción.
% b) Leonardo DiCaprio actúa en Inception.
% c) Christopher Nolan dirige Inception.
% d) Tom Hanks actúa en Forrest Gump.
% e) Forrest Gump es una película de drama.
% f) Steven Spielberg dirige Jurassic Park.
% g) Jurassic Park es una película de aventura.
% Hechos extra para cumplir el requisito:
%   - Sam Neill en Jurassic Park
%   - Robin Wright en Forrest Gump
%   - Christian Bale en The Dark Knight
%   - The Dark Knight como película de acción
%   - Nolan dirige The Dark Knight

actor(leonardo_dicaprio, inception).
actor(tom_hanks, forrest_gump).
actor(sam_neill, jurassic_park).
actor(robin_wright, forrest_gump).
actor(christian_bale, the_dark_knight).

pelicula(forrest_gump, drama).
pelicula(jurassic_park, aventura).
pelicula(inception, ciencia_ficcion).
pelicula(the_dark_knight, accion).

director(steven_spielberg, jurassic_park).
director(christopher_nolan, inception).
director(christopher_nolan, the_dark_knight).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PARTE 2: CONSULTAS Y SALIDAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% a) ¿Cuáles películas dirige Christopher Nolan?
% ?- director(christopher_nolan, TituloPelicula).
%   TituloPelicula = inception ;
%   TituloPelicula = the_dark_knight.
% (Unificación: Prolog busca hechos director donde el primer argumento sea
%  christopher_nolan. En cada coincidencia, TituloPelicula queda asociado al
%  segundo argumento del hecho. Con ';' pide otra coincidencia. No hay más → fin.)

% b) ¿Qué actores actúan en películas de ciencia ficción?
% ?- pelicula(TituloPelicula, ciencia_ficcion), actor(NombreActor, TituloPelicula).
%   TituloPelicula = inception, NombreActor = leonardo_dicaprio.
% (Unificación: primero se satisface pelicula(TituloPelicula, ciencia_ficcion).
%  Eso deja TituloPelicula = inception. Luego, esa misma variable se reutiliza
%  en actor(NombreActor, TituloPelicula); como TituloPelicula ya vale inception,
%  Prolog busca un actor en esa peli y devuelve NombreActor = leonardo_dicaprio.
%  Si hubiera más actores en inception, con ';' Prolog los iría devolviendo de a uno.)

% c) Lista todas las películas y sus géneros.
% ?- pelicula(TituloPelicula, Genero).
%   TituloPelicula = forrest_gump,   Genero = drama ;
%   TituloPelicula = jurassic_park,  Genero = aventura ;
%   TituloPelicula = inception,      Genero = ciencia_ficcion ;
%   TituloPelicula = the_dark_knight,Genero = accion.
% (Unificación: TituloPelicula y Genero quedan asociados a cada par guardado en
%  los hechos pelicula. Con ';' se recorren todas las opciones vía backtracking.)

% d) ¿Hay algún actor que actúe en Inception y en otra película?
% ?- actor(NombreActor, inception), actor(NombreActor, OtraPelicula), OtraPelicula \= inception.
%   false.
% (Unificación: primero se fija NombreActor con quien esté en inception (leonardo_dicaprio).
%  Luego se busca actor(NombreActor, OtraPelicula) con el mismo NombreActor.
%  La condición OtraPelicula \= inception exige que sea distinta, pero no hay otra
%  coincidencia para ese actor, entonces falla. Con backtracking no aparece nada más.)

% Consultas propias:

% 1) Emparejar actor–director por película:
% ?- actor(Actor, Pelicula), director(Director, Pelicula).
%   Actor = sam_neill,        Pelicula = jurassic_park,  Director = steven_spielberg ;
%   Actor = leonardo_dicaprio,Pelicula = inception,      Director = christopher_nolan ;
%   Actor = christian_bale,   Pelicula = the_dark_knight,Director = christopher_nolan.
% (Unificación: primero actor(Actor, Pelicula) fija Actor y Pelicula. Después se exige
%  director(Director, Pelicula) con la misma Pelicula ya determinada. Backtracking:
%  Prolog explora todas las combinaciones donde ambos predicados coinciden en Pelicula.)

% 2) Actores en películas de Spielberg:
% ?- director(steven_spielberg, Pelicula), actor(Actor, Pelicula).
%   Pelicula = jurassic_park, Actor = sam_neill.
% (Unificación: se fija primero Pelicula desde director(steven_spielberg, Pelicula),
%  quedando Pelicula = jurassic_park. Luego con actor(Actor, Pelicula) se busca quién
%  actúa en esa misma película. Con ';' listaría más actores si existieran en la base.)

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PARTE 3: REGLAS
%%%%%%%%%%%%%%%%%%%%%%%%%%
% a) Actúa en un género si actúa en alguna película de ese género
actua_en_genero(NombreActor, Genero) :- actor(NombreActor, TituloPelicula), pelicula(TituloPelicula, Genero).

% b) Colaboración si dos actores comparten una misma película (y son distintos)
colaboracion(NombreActor1, NombreActor2) :- actor(NombreActor1, TituloPelicula),actor(NombreActor2, TituloPelicula),NombreActor1 \= NombreActor2.

% c) Un director es de un género si dirige alguna película de ese género
director_de_genero(NombreDirector, Genero) :-director(NombreDirector, TituloPelicula),pelicula(TituloPelicula, Genero).

% d) Una película tiene colaboración si posee al menos dos actores distintos
pelicula_con_colaboracion(TituloPelicula) :-actor(NombreActor1, TituloPelicula),actor(NombreActor2, TituloPelicula),NombreActor1 \= NombreActor2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% REGLA ADICIONAL PROPIA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Relación actor–director si comparten película
trabaja_con_director(Actor, Director) :-actor(Actor, Pelicula),director(Director, Pelicula).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PARTE 4: ANÁLISIS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejemplo de consulta: ?- pelicula(Titulo, ciencia_ficcion), actor(Actor, Titulo).
% Prolog va de izquierda a derecha. Primero busca una peli de ciencia ficción,
% obtiene Titulo = inception. Con eso, busca un actor en esa peli y da Actor = leonardo_dicaprio.
% Si se aprieta ';', Prolog intenta alternativas (backtracking). Como no hay más actores
% en inception ni otra peli de ciencia ficción en esta base, termina ahí.

% La unificación hace que las variables se asocien a los valores que hacen coincidir
% cada meta. Si algo no encaja (ejemplo: desigualdad con \=), Prolog falla y vuelve atrás
% a probar otra opción. Así recorre todas las posibilidades hasta agotar las soluciones.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PARTE 5: EXTENSIÓN sexo/actriz
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sexo(leonardo_dicaprio, masculino).
sexo(tom_hanks, masculino).
sexo(sam_neill, masculino).
sexo(robin_wright, femenino).
sexo(christian_bale, masculino).

actriz_en_pelicula(Nombre, Pelicula) :-sexo(Nombre, femenino),actor(Nombre, Pelicula).

% Pruebas rápidas:
% ?- actriz_en_pelicula(Nombre, forrest_gump).   % Nombre = robin_wright.
% ?- actriz_en_pelicula(Nombre, inception).      % false.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PARTE 6: PRUEBAS DE REGLAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ?- actua_en_genero(leonardo_dicaprio, Genero).       % Genero = ciencia_ficcion.
% ?- colaboracion(tom_hanks, Otro).                    % Otro = robin_wright.
% ?- director_de_genero(christopher_nolan, Genero).    % Genero = ciencia_ficcion ; Genero = accion.
% ?- pelicula_con_colaboracion(Pelicula).              % Pelicula = forrest_gump.
% ?- trabaja_con_director(christian_bale, Director).   % Director = christopher_nolan.
% ?- actriz_en_pelicula(Nombre, forrest_gump).         % Nombre = robin_wright.
