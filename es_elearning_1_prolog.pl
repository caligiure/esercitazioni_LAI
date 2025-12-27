% Definire un predicato prolog zipunequals/3 che abbia come primo e secondo termine 
% due liste L1 e L2 e come terzo termine una lista L3 tali che:
% L3 contiene una sequenza di termini f(x,y) che corrispondono alle posizioni 
% i-esime di L1 e L2 tali che x e y sono i termini che appaiono in posizione 
% i-esima in L1 e L2 rispettivamente e y e x non unifica con y. 

% esempio:
% goal:  zipunequals([1,2,3],[6,2,1], L3).
% risultato: L3 = [f(1,6),f(3,1)]

% il predicato deve funzionare (almeno) in modalitá +, +, -

zipunequals([], [], []).
zipunequals([H1|T1], [H2|T2], [f(H1, H2)|T3]) :- H1\=H2, !, zipunequals(T1, T2, T3).
zipunequals([_|T1], [_|T2], T3) :- zipunequals(T1, T2, T3).



% Supponendo di avere una base di fatti per i seguenti predicati: 
% persona/2, amico/2, maschio/1, femmina/1, dove persona contenga come primo termine 
% il nome della persona e come secondo la sua etá

% Si definiscano i predicati seguenti:
%     soloamicigrandi(X): vero se e solo X ha solamente amici più grandi di lui
%     amicistessaeta(X): vero se e solo tutti gli amici di X hanno la medesima etá
%     stessaetadegliamici(X,Y): vero se e solo se X e Y hanno degli insiemi di amici 
%       AX e AY tali che la somma delle etá degli amici in AX e AY coincidano

haalmenounamicopiccolo(X) :- amici(X,Y), persona(X,E1), persona(Y,E2), E1>E2.
soloamicigrandi(X) :- persona(X,_), \+ haalmenounamicopiccolo(X).

haamiciconetadiverse(X) :- amici(X,Y), persona(X,E1), persona(Y,E2), E1\=E2.
amicistessaeta(X) :- persona(X,_), \+ haamiciconetadiverse(X).

sum([], 0).
sum([E|C], S) :- sum(C, S1), S is S1+E.
sommaetaamici(X, S) :- bagof(E, Y^(amico(X,Y), persona(Y,E)), L), sum(L,S).
stessaetadegliamici(X,Y) :- sommaetaamici(X,S1), sommaetaamici(Y,S2), X\=Y, S1\=S2.
