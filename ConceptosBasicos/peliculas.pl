%Agrega al menos 5 hechos adicionales para enriquecer la base (más películas o actores).
%a) "Inception" es una película de ciencia ficción.
%b) Leonardo DiCaprio actúa en Inception.
%c) Christopher Nolan dirige Inception.
%d) Tom Hanks actúa en Forrest Gump.
%e) Forrest Gump es una película de drama.
%f) Steven Spielberg dirige Jurassic Park.
%g) Jurassic Park es una película de aventura.

actor(leonardo_dicaprio,inception).
actor(tom_hanks,forrest_gump).
actor(sam_neill,jurassic_park).
actor(robin_wright,forrest_gump).
actor(christian_bale,the_dark_knight).

pelicula(forrest_gump,drama).
pelicula(jurassic_park,aventura).
pelicula(inception,ciencia_ficcion).
pelicula(the_dark_knight,accion).

director(steven_spielberg,jurassic_park).
director(christopher_nolan,inception).
director(christopher_nolan,the_dark_knight).

actua_en_genero(NombreActor, Genero) :- actor(NombreActor, TituloPelicula), pelicula(TituloPelicula, Genero).
colaboracion(NombreActor1, NombreActor2) :- actor(NombreActor1, TituloPelicula), actor(NombreActor2, TituloPelicula), NombreActor1 \= NombreActor2.
director_de_genero(NombreDirector, Genero) :- director(NombreDirector, TituloPelicula), pelicula(TituloPelicula, Genero).
pelicula_con_colaboracion(TituloPelicula) :- actor(NombreActor1, TituloPelicula), actor(NombreActor2, TituloPelicula), NombreActor1 \= NombreActor2.
trabaja_con_director(Actor, Director) :- actor(Actor, Pelicula), director(Director, Pelicula).
