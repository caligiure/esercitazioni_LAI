% Definire una predicato segmentList/2. segmentList(X,Y) è vero se X è una lista di interi e 
% Y una lista di liste di interi dove le liste in Y sono le sottoliste consecutive di X 
% ottenute rispettando le seguenti regole:
%   Ogni sottolista deve contenere numeri consecutivi crescenti (esempio: [3, 4, 6] o [10, 12]).
%   Quando la sequenza si interrompe (esempio: passando da 5 a 4), inizia una nuova sottolista.
%   La funzione deve restituire una lista di sottoliste.

% segmentList([3, 4, 5, 4, 9, 10, 3, 4, 12, 13, 14, 20], [[3, 4, 5], [4, 9, 10], [3, 4, 12, 13, 14, 20]])

segmentList([], []).

segmentList([H|T], [Segmento|OtherSegments]) :-
    buildSegment(T, [H], Segmento, Resto), % Ottiene il Segmento completo e il Resto della lista che non è stato ancora processato
    segmentList(Resto, AltriSegmenti).


% Questo predicato ha firma: buildSegment(ListaInput, Accumulatore, SegmentoFinale, ListaRimanente)
buildSegment([], Acc, Segmento, []) :- reverse(Acc, Segmento). % Se la lista di input è finita ([]), il segmento è finito e il resto della lista è vuoto

buildSegment([X|Xs], [Prev|RestAcc], Segmento, RestoFinale) :- 
    X > Prev, !,    % Confronta l'elemento corrente (X) con l'ultimo inserito (Prev). Il cut dice "se siamo arrivati qui, non tornare indietro a cercare altre soluzioni".
    buildSegment(Xs, [X,Prev|RestAcc], Segmento, RestoFinale).

buildSegment([X|Xs], Acc, Segmento, [X|Xs]) :- % Questa clausola viene attivata se la regola precedente fallisce (cioè se X =< Prev)
    reverse(Acc, Segmento).



% Supponendo di avere una base di fatti per i seguenti predicati: persona/2, amico/2, maschio/1, femmina/1, 
% dove persona contenga come primo termine il nome della persona e come secondo la sua età
% Si definiscano i predicati seguenti:
% p1(X): #vero se e solo tutte le amiche femmine di X sono più grandi di tutti gli amici maschi di X
% p2(X): #vero se e solo se gli amici più anziani di X (che non sono più piccoli di un altro amico di X) sono tutti maschi
% stessaetadegliamici(X): #vero se e solo se l'età di X è uguale alla somma delle

p1(X) :- persona(X, _), \+ esisteAmicaFemPiuGrandeDiAmicoMas(X).

esisteAmicaFemPiuPiccolaDiAmicoMas(X) :- persona(F, EF), femmina(F), amico(F,X), persona(M, EM), maschio(M), amico(M,X), EF=<EM.


p2(X) :- persona(X,_), \+ (amicoPiuAnziano(X, A), femmina(A)).

amicoPiuAnziano(X, A1) :- persona(A1, E1), amico(X, A1),
    \+ (
        persona(A2, E2), amico(X, A2), E2>E1. % non ci sono altri amici di X più anziani di A1
    )


stessaetadegliamici(X) :- 
    persona(X, EtaX), 
    findall(EtaA, (amico(X, A), persona(A, EtaA)), ListeEta),
    % findall serve a creare una lista di risultati. Ha 3 argomenti:
    %   Template (EtaA): è ciò che vogliamo raccogliere nella lista
    %   Obiettivo ((amico(X, A), persona(A, EtaA))): è la condizione che deve essere vera affinchè un elemento faccia parte della lista
    %   Risultato (ListeEta): tutti i risultati trovati vengono messi in questa variabile, che diventerà una lista
    %   In sinstesi: "Trova tutti gli amici di X, recupera le loro età e mettile tutte dentro la lista ListeEta"
    sum_list(ListeEta, Somma),
    EtaX =:= Somma.     % L'operatore =:= serve per confrontare valori numerici.


% Descrivere in pseudocodice l'algoritmo di unificazione di due termini della logica del primo ordine.

