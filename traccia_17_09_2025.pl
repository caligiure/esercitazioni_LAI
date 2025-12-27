% Definire un predicato prolog zip(L1,L2,L3) tale che L1 e L2 sono due liste 
% ed L3 una lista di lunghezza pari alla lunghezza minima fra L1 e L2 
% contente per ogni posizione i il termine c(Xi, Yi) dove Xi (risp. Yi) 
% è il termine in posizione i-esima di L1 (risp. L2)

% il predicato deve funzionare in modalitá (+,+, -) e (-, -, +)

% Esempio: zip([g, a, t, t, o], [g, o, t], [c(g,g), c(a,o), c(t, t)]) è vero

zip([],_,[]).
zip([_|_],[],[]).
zip([H1|T1],[H2|T2],[c(H1,H2)|T3]) :- zip(T1,T2,T3).



% Si considerino i seguenti predicati
studente(nome, cognome, matricola)
esame(idcorso, matricola, voto)
corso(idcorso, nome)
% si definisca il seguente predicato prolog:
% media(matricola, valore) che restituisce vero se la media degli esami 
% sostenuti dallo studente avente come matricola il primo termine è uguale a valore
% (si assuma che ogni corso sia caratterizzato dallo stesso numero di crediti)

media(Matricola, Valore) :- studente(_, _, Matricola), 
    findall(Voto, esame(_, Matricola, Voto), Lvoti), 
    length(Lvoti, N),
    N > 0, % controllo anti-crash
    sum_list(Lvoti, Somma), 
    Valore is Somma / N.



% Riportare la definizione di most general unifier (mgu) di due termini della logica 
% del primo ordine, descrivendo in pseudocodice un algoritmo in grado di 
% calcolare il mgu di due termini