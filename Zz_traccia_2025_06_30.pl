gara(nome)
vincitore(nomepilota, nomegara, anno).
pilota(nome).

% Definire:
% - pilotivittoriosi (NomePilota, Num) - vero se NomePilota ha vinto Num gare.
% - dominatore(NomePilota,Num) - vero se NomePilota ha vinto tutte le gare (le gare possono essere state vinte anche in anni diversi)
% - fedelissimo (NomePilota) - vero se NomePilota ha vinto gare in almeno 3 anni consecutivi.

pilotivittoriosi(NomePilota, Num) :- 
    pilota(NomePilota),
    findall(NomeGara, vincitore(NomePilota, NomeGara, _), L),
    length(L, Num).

dominatore(NomePilota) :- 
    pilota(NomePilota),
    \+(gara(G), \+ vincitore(NomePilota, G, _)).
% la traccia chiedeva un pilota che avesse vinto tutte le gare disponibili 
% (es. ha vinto sia a Monza, sia a Imola, sia a Spa), 
% anche se in anni diversi e anche se altri hanno vinto quelle stesse gare in altri anni.

fedelissimo(NomePilota) :- 
    vincitore(NomePilota, _, A1), vincitore(NomePilota, _, A2), vincitore(NomePilota, _, A3),
    A2 =:= A1 + 1,
    A3 =:= A2 + 1.



% Quale tra i seguenti predicati implementa correttamente la negazione come fallimento not/1?

neg1(X):- X,!,fail. % questa
neg1(_).

neg2(X):- X,fail,!.
neg2(_).

neg3(X):- call(X),fail.
neg3(_).



% definire il predicato elementipari(ListaIn,ListaOut) che restituisce, data una lista ListaIn, 
% una lista ListaOut contenente solo gli elementi che si trovano in posizione pari (seconda,quarta ecc)
% esempio: elementipari([a,b,c,d,e,f],L)% L=[b,d,f]

elementipari([], []).

elementipari([_], []).

elementipari([_, B|T], [B|T1]) :- elementipari(T, T1).
