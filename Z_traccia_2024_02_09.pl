% Definire un predicato segmentList/2. segmentList(X,Y) è vero se X è una lista di interi
% e Y una lista di liste di interi dove le liste in Y sono le sottoliste consecutive di X 
% ottenute rispettando le seguenti regole:
%    Ogni sottolista deve contenere numeri consecutivi in base alla differenza di 1
%    (esempio: [3, 4, 5] o [10, 11]).
%    Quando la sequenza si interrompe (esempio: passando da 5 a 8), inizia una nuova sottolista.
%    La funzione deve restituire una lista di sottoliste.
% Es. segmentList([3, 4, 5, 8, 9, 10, 3, 4, 12, 13, 14, 20], 
%           [[3, 4, 5], [8, 9, 10], [3, 4], [12, 13, 14], [20]])

segmentList([],[]).

segmentList([Curr|RestoX], [Seg|OtherSeg]) :-
    checkSeg(Curr, RestoX, Seg, Xrimanente), % (+, +, +, -)
    segmentList(Xrimanente, OtherSeg).


checkSeg(Curr, [Succ|RestoX], [Curr|RestoY], Xrimanente) :-
    Succ =:= Curr + 1, !, % Cut per efficienza (se entra qui, non deve provare le altre)
    checkSeg(Succ, RestoX, RestoY, Xrimanente).

% NOTA: [Curr] impone che nel segmento sia rimasto solo l'elemento Curr, in modo da
% esculdere i casi in cui il sgemento contiene altri elementi che non dovrebbero esserci
checkSeg(Curr, [Succ|RestoX], [Curr], [Succ|RestoX]) :-
    Succ =\= Curr + 1.

checkSeg(Curr, [], [Curr], []).



% Supponendo di avere una base di fatti per i seguenti predicati: 
% persona/2, amico/2, maschio/1, femmina/1, 
% dove persona contenga come primo termine il nome della persona e come secondo la sua etá
% Si definiscano i predicati seguenti:
%    p1(X): vero se e solo X tutte le amiche femmine di X sono più grandi di almeno un amico maschio di X
%    p2(X): vero se e solo se almeno uno degli amici più anziani di X 
%    (che non sono più piccoli di un altro amico di X) è maschio
%    stessaetadegliatri(X): vero se e solo se X ha un amico Y la cui etá è uguale alla somma delle etá 
%    degli altri amici di X

p1(X) :- persona(X, _),
    \+ (amico(F, X), F\=X, femmina(F), persona(F, EF),                % non è vero che esiste un'amica femmina di X tale che
        \+ (amico(M, X), M\=X, maschio(M), persona(M, EM), EM < EF)). % non esiste un amico maschio di X più piccolo di lei

p2(X) :- persona(X, _),
    amico(A, X), A\=X, maschio(A), persona(A, EA),         % esiste un amico maschio di X tale che
    \+ (amico(X, B), B\=X, persona(B, EB), A\=B, EB>EA).   % non esiste un altro amico di X più anziano di lui

stessaetadegliatri(X) :- persona(X, _),
    amico(X, Y), X\=Y, persona(Y, EY),                          % esiste un amico di X tale che
    findall(EZ, (amico(X, Z), Z\=X, Z\=Y, persona(Z, EZ)), L),
    somma_lista(L, S), % potevo usare sum_list
    EY =:= S.            % l'età di Y è uguale alla somma delle età degli altri amici di X

somma_lista([], 0).
somma_lista([H|T], S) :- somma_lista(T, S2), S is H + S2.



% Descrivere l'algoritmo di unificazione di due espressioni logiche