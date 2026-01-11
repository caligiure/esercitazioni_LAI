% Definire il predicato sottolisten(N, ListaIn, ListaOut) che,
% presa una lista di elementi ground, ListaIn, restituisce la lista
% composta dalle sottoliste di elementi contigui di ListaIn lunghe N.

sottolisten(N, [H|T], [Seg|OtherSeg]) :- 
    build_seg(N, [H|T], Seg), !,
    sottolisten(N, T, OtherSeg).

sottolisten(_, _, []).

build_seg(0, _, []).

build_seg(N, [H|T], [H|Res]) :- 
    N1 is N - 1,
    build_seg(N1, T, Res).