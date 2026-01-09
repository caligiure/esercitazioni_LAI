% Data una base di conoscenza prolog che contiene i predicati
%    arco(X,Y) -- dove X e Y sono termini (semplici) che rappresentano nodi
%    nodo(X,V) -- dove X è un nodo e V un valore numerico che rappresenta 
%                 il valore di un nodo.
% Definire in prologo i seguenti predicati:
%    valoreraggiungibile(X,V) che è vero se e solo se X è un nodo 
%       e V e è il valore di un nodo raggiungibile da X.
%    maxVraggiungibile(X,V) che  vero se e solo se X è un nodo e 
%    V e è il massimo fra i valori associati ai nodi raggiungibili da X.

valoreraggiungibile(X, V) :- arco(X, Y), nodo(Y, V).

valoreraggiungibile(X, V) :- arco(X, Y), valoreraggiungibile(Y, V).

% IMPORTANTE: NON USIAMO FINDALL
maxVraggiungibile(X, V) :- valoreraggiungibile(X, V), \+ (valoreraggiungibile(X, V2), V2 >V).



% Data una base di conoscenza prolog che contiene i predicati
%    arco(X,Y) -- dove X e Y sono termini (semplici) che rappresentano nodi
%    nodo(X,V) --- dove X è un nodo e V un valore numerico che rappresenta il valore di un nodo.
% Definire in prolog il predicato  cricca(K) che restituisce vero se esiste un insieme di nodi X 
% (suggerimento: si può rappresentare come una lista) tale che:
%    |X|>=k
%    per ogni coppia di nodi A,B in X arco(A,B) è vero

cricca(K) :- 
    findall(N, nodo(N, _), ListaNodi),  % creo lista di tutti i nodi
    sottoinsieme(ListaNodi, Candidato), % genera un sottoinsieme candidato (ricorsivamente Prolog proverà a generarli tutti finchè non trova una cricca)
    length(Candidato, Dim),             % calcola dimensione
    Dim >= k,
    is_cricca(Candidato).

% Generatore di Sottoinsiemi: per ogni elemento posso decidere 
% se tenerlo ([H|RestoSottoinsieme]) o scartarlo (RestoSottoinsieme).
sottoinsieme([],[]).
sottoinsieme([H|T], [H|RestoSottoinsieme]) :- sottoinsieme(T, RestoSottoinsieme).
sottoinsieme([_|T], [RestoSottoinsieme]) :- sottoinsieme(T, RestoSottoinsieme).


is_cricca([]).
is_cricca([H|T]) :- connessoATutti(H, T), is_cricca(T).

connessoATutti(N, []).
connessoATutti(N, [H|T]) :- arco(N, H), arco(H, N), connessoATutti(N, T).


% VERSIONE ALTERNATIVA (è inefficiente?)
is_cricca2(Subset) :- \+ (nodo(A, _), nodo(B, _), member(A, Subset), member(B, Subset), \+ arco(A, B)).





Riportare la definizione formale di mgu (most general unifier) di due termini della logica del primo ordine. Spiegare il modivo per cui l'algoritmo di risoluzione di prolog fa riferimento al mgu invece che a un normale unificatore nel processo di risoluzione.


