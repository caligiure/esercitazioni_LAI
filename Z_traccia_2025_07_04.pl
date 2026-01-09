% Data una base di conoscenza prolog che rappresenta un grafo 
% orientato pesato su archi e nodi tramite i predicati
%    arco(X,Y,V) -- dove X e Y sono termini (semplici) che rappresentano nodi 
%                   e V è un valore numerico che rappresenta il peso di un arco
%    nodo(X,V) --- dove X è un nodo e V un valore numerico che rappresenta il valore di un nodo.
% Definire in prologo i seguenti predicati:
%    valoreraggiungibile(X, Y, V) che è vero se e solo se X è un nodo, 
%           Y è un nodo raggiungibile da X 
%           e V e è il valore dato dal prodotto dei valori degli archi 
%           che compongono il cammino con cui si raggiunge Y da X moltiplicato per il valore di Y.
%    maxVraggiungibile(X,V) che  vero se e solo se X è un nodo e V è il massimo 
%           fra i valori associati ai nodi raggiungibili da X dal predicato valoreraggiungibile

valoreraggiungibile(X, Y, V) :- nodo(X, _), nodo(Y, VY), prodottoCammino(X, Y, P), V is P * VY.

prodottoCammino(X, Y, V) :- arco(X, Y, V).
prodottoCammino(X, Y, P) :- arco(X, K, V), prodottoCammino(K, Y, P2), P is V * P2.

maxVraggiungibile(X, V) :- valoreraggiungibile(X, _, V), \+(valoreraggiungibile(X, _, V1), V1 > V).

% PROBLEMA: valoreraggiungibile va in loop se il grafo contiene dei cicli
% INEFFICIENZA: maxVraggiungibile è inefficiente nella ricerca del massimo
% SOLUZIONE: gestione dei cicli ed efficientamento, implementando una lista di nodi già visitati

valoreraggiungibile2(X, Y, V) :- nodo(X, _), nodo(Y, VY), prodottoCammino2(X, Y, [X], P), V is P * VY.

prodottoCammino2(X, Y, Visitati, V) :- arco(X, Y, V), \+ member(Y, Visitati).
prodottoCammino2(X, Y, Visitati, P) :- arco(X, Next, V), \+ member(Next, Visitati),
    prodottoCammino2(Next, Y, [Next|Visitati], P2), P is V * P2.

maxVraggiungibile(X, V) :- nodo(X, _), findall(Val, valoreraggiungibile(X, _, Val)2, L),
    L \= [], cerca_massimo(L, V).

cerca_massimo([E], E).
cerca_massimo([M1|T], Max) :- cerca_massimo(T, M2), scegli_massimo(M1, M2, Max).

scegli_massimo(E1, E2, E1) :- E1 >= E2, !.
scegli_massimo(E1, E2, E2) :- E2 > E1.

% NOTA: tutto il blocco cerca_massimo e scegli_massimo puè essere sostituito con la funzione standard di Prolog max_list(L, V)





% Si considerino i seguenti predicati
studente(nome, cognome, matricola)
esame(idcorso, matricola, voto)
corso(idcorso, nome, CFU)
% si definisca il seguente predicato prolog:
% mediapesata(matricola, valore) che restituisce vero se la media degli esami 
% sostenuti dallo studente avente come matricola il primo termine è uguale a valore. 
% La media deve essere calcolata pesando i voti degli esami per i CFU dei vari corsi, 
% ad esempio se lo studente ha fatto l'esame 1 da 12 CFU con voto 30 è l'esame 2 da 
% 6 CFU con voto 20 la media sará (30*12+20*6)/18

mediapesata(Matricola, Valore) :- 
    studente(_, _, Matricola), 
    findall(
        coppia(VotoPesato, CFU),
        (esame(IDCorso, Matricola, Voto),
            corso(IDCorso, _, CFU),
            VotoPesato is Voto * CFU),
        ListaVoti),
    calcolasomma(ListaVoti, SommaVoti, SommaCFU),
    SommaCFU > 0,
    Valore is SommaVoti / SommaCFU.

calcolasomma([], 0, 0).

calcolasomma([coppia(Voto, CFU)|Resto], SommaVoti, SommaCFU) :-
    calcolasomma(Resto, SommaVotiResto, SommaCFUResto),
    SommaVoti is Voto + SommaVotiResto,
    SommaCFU is CFU + SommaCFUResto.





% Descrivere in pseudocodice l'algoritmo di unificazione di due termini della logica del primo ordine