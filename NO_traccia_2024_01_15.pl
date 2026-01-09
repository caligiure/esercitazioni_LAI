Definire una predicato segmentList/2. segmentList(X,Y) è vero se X è una lista di interi e Y una lista di interi dove le liste in Y sono le sottoliste consecutive di X ottenute rispettando le seguenti regole:

    Ogni sottolista deve contenere numeri consecutivi in base alla differenza di 1 (esempio: [3, 4, 5] o [10, 11]).
    Quando la sequenza si interrompe (esempio: passando da 5 a 8), inizia una nuova sottolista.
    La funzione deve restituire una lista di sottoliste.

segmentList([3, 4, 5, 8, 9, 10, 3, 4, 12, 13, 14, 20], [[3, 4, 5], [8, 9, 10], [3, 4], [12, 13, 14], [20]])










Supponendo di avere una base di fatti per i seguenti predicati: persona/2, amico/2, maschio/1, femmina/1, dove persona contenga come primo termine il nome della persona e come secondo la sua etá-

Si definiscano i predicati seguenti:

    p1(X): vero se e solo X tutte le amiche femmine di X sono più grandi di almeno un amico maschio di X
    p2(X): vero se e solo se almeno uno degli amici più anziani di X (che non sono più piccoli di un altro amico di X) è maschio
    stessaetadegliatri(X): vero se e solo se X ha un amico Y la cui etá è uguale alla somma delle etá degli altri amici di X








Descrivere l'algoritmo di unificazione di due espressioni logiche.



