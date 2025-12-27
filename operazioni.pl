% --- OPERAZIONI SUI NUMERI NATURALI ---

% Definizione dei numeri naturali usando la notazione Peano
nat(z). % Questo è il caso base. Dichiara che z (che rappresenta lo zero) è un numero naturale.
nat(s(X)) :- nat(X). % Questo è il caso ricorsivo. Dichiara che se X è un numero naturale, allora s(X) (il successore di X) è anch'esso un numero naturale.

% Definizione dell'operazione di addizione sui numeri naturali
add(z,N,N) :- nat(N).  % Aggiungere zero a un numero naturale N restituisce N.
add(s(N),M,s(P)) :- add(N,M,P). % Aggiungere il successore di N a M restituisce il successore di P, dove P è la somma di N e M.
% In altre parole, add(s(N), M) = s(add(N, M)).

multiply(z,_,z). % Moltiplicare zero per qualsiasi numero naturale restituisce zero.
multiply(s(N),M,P) :- multiply(N,M,Q), add(M,Q,P). % Moltiplicare il successore di N per M restituisce P, dove P è la somma di M e Q, e Q è il prodotto di N e M.
% In altre parole, multiply(s(N), M) = add(M, multiply(N, M))

square(N,P) :- multiply(N,N,P). % Il quadrato di N è P, dove P è il prodotto di N per se stesso.

% --- OPERAZIONI SULLE LISTE ---

% Definizione delle liste
list([]). % La lista vuota è una lista valida.
list([X|L]) :- list(L). % Una lista è valida se la sua coda L è una lista valida.

append([],L,L). % Concatenare una lista vuota con L restituisce L.
append([X|L],M,[X|N]) :- append(L,M,N). % Concatenare una lista con testa X e coda L con M restituisce una lista con testa X e coda N, dove N è la concatenazione di L e M.

append(+,+,-). % Specifica dei modelli di modalità per l'operazione di append
% + indica che l'argomento deve essere fornito (input)
% - indica che l'argomento deve essere calcolato (output)
append(-,-,+).

member(X,[X|_]). % X è un membro della lista se è la testa della lista.
member(X,[_|L]) :- member(X,L). % X è un membro della lista se è un membro della coda L.
% typical modes:
member(+,+).
member(-,+).

remove(X,[X|L],L). % Rimuovere X dalla lista con testa X e coda L restituisce L.
remove (X,[Y|L],[Y|M]) :- remove(X,L,M). % Rimuovere X dalla lista con testa Y e coda L restituisce una lista con testa Y e coda M, dove M è la lista risultante dalla rimozione di X da L.

flatten(X, [X]) :- var(X).
flatten(X, [X]) :- atomic(X), X\=[].
% oppure(?): flatten(X, [X]) :- X \= [], X \= [_|_].
flatten([],[]).
flatten([L1|LL],F) :- flatten(L1,F1), flatten(LL,F2), append(F1,F2,F).

