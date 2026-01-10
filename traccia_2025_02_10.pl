% Definire una predicato segmentList/2. segmentList(X,Y) è vero se X è una lista di interi
% e Y una lista di interi dove le liste in Y sono le sottoliste consecutive di X 
% ottenute rispettando le seguenti regole:
% Ogni sottolista deve contenere numeri consecutivi crescenti (esempio: [3, 4, 6] o [10, 12]).
% Quando la sequenza si interrompe (esempio: passando da 5 a 4), inizia una nuova sottolista.
% La funzione deve restituire una lista di sottoliste.
% segmentList([3, 4, 5, 4, 9, 10, 3, 4, 12, 13, 14, 20], [[3, 4, 5], [4, 9, 10], [3, 4], [12, 13, 14, 20]])

segmentList([], []).
segmentList([H|T], [Subl|Othersubl]) :- check_subl(H, T, Subl, RestoT), segmentList(RestoT, Othersubl).

check_subl(Curr, [], [Curr], []).

check_subl(Curr, [Succ|RestoT], [Curr], [Succ|RestoT]) :- Succ < Curr, !.

check_subl(Curr, [Succ|T], [Curr|RestoSubl], RestoT) :-
    Succ >= Curr,
    check_subl(Succ, T, RestoSubl, RestoT).



% Supponendo di avere una base di fatti per i seguenti predicati: 
% persona/2, amico/2, maschio/1, femmina/1, dove persona contenga 
% come primo termine il nome della persona e come secondo la sua età
% Si definiscano i predicati seguenti:
% p1(X): vero se e solo tutte le amiche femmine di X sono più grandi di tutti gli amici maschi di X
% p2(X): vero se e solo se gli amici più anziani di X (che non sono più piccoli di un altro amico di X) sono tutti maschi
% stessaetadegliamici(X): vero se e solo se l'età di X è uguale alla somma delle





% Descrivere in pseudocodice l'algoritmo di unificazione di due termini della logica del primo ordine.