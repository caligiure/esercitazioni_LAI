% 1) dare la definizione di Logic entailment e descrivere l'algoritmo di logical entailmnet tra due espressioni proposizionali



% 2) definire una funzione che prende due liste l1 e l2 e restituisce true
% se L2 può essere ottenuta rimuovendo alcuni elementi da l1
p1(_,[]).
p1([H1|T1], [H2|T2]) :- H1==H2, p1(T1, T2).
p1([_|T1], [H2|T2]) :- p1(T1, [H2|T2]).

% versione più bella:
sub(_, []).
sub([H|T1], [H|T2]) :- sub(T1, T2).
sub([_|T1], L2) :- sub(T1, L2).


% 3) dati i predicati
femmina(nome).
maschio(nome).
persona(nome età)
amico(nome, nome)
% Definire i predicati:
% Tuttefemmine(X) se X ha solo amici femmine
% Amicistessaeta(X) se X ha una coppia di amici della stessa età
% Comuni(X,Y) se l'insieme di amici di X coincide con Y

tuttefemmine(X) :- persona(X, _), \+ (
    amico(X,A), maschio(A)
).

amicistessaeta(X) :- persona(X,_), amico(X,A1), amico(X,A2), A1\=A2,
    persona(A1,E1), persona(A2,E2), E1=E2, !.

comuni(X,Y) :- findall(AX, amico(X,AX), LX), findall(AY, amico(Y,AY), LY), insiemiCoincidenti(LX,LY).

insiemiCoincidenti(L1,L2) :- sottoinsieme(L1,L2), sottoinsieme(L2,L1).

sottoinsieme([],_).
sottoinsieme([E1|L1], L2) :- elementoContenuto(E1,L2), sottoinsieme(L1,L2).

elementoContenuto(E, [E|_]).
elementoContenuto(E, [_|T]) :- elementoContenuto(E,T).