nodo(7,4,8).
nodo(4,2,9).
nodo(2,nil,nil).
nodo(9,nil,nil).
nodo(8,5,1).
nodo(5,nil,nil).
nodo(1,nil,6).
nodo(6,nil,nill).

preorden(nil):-!.
preorden(R):- write(R), nodo(R,HI,HD),preorden(HI),preorden(HD).

inorden(nil):-!.
inorden(R):- nodo(R,HI,HD),inorden(HI),write(R),inorden(HD).

postorden(nil):-!.
postorden(R):- nodo(R,HI,HD),postorden(HI),postorden(HD),write(R).