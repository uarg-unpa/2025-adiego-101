:-dynamic(alumno/1).
:-dynamic(escuela/2).
alumno(gonzales).
alumno(perez).
alumno(aguirre).
escuela(gonzales, industrial6).
escuela(perez, enet1).
es_alumno(X,Y) :- alumno(X), escuela(X,Y).