-- Definire una funzione removeElementsByIndices che prende in input una lista
-- di interi (indices) e una lista generica (list) e  restituisce una nuova 
-- lista contenente solo gli elementi di list che non si trovano nelle 
-- posizioni specificate dagli indici nella lista indices nell'ordine in cui
-- appaiono nella lista list. 
-- removeElementsByIndices :: [Int] -> [a] -> [a]
-- Esempio:
-- removeElementsByIndices [1,4,2,1] ['a', 'c', '3', 'r', '3'] restituisce "ar"

removeElementsByIndices :: [Int] -> [a] -> [a]
removeElementsByIndices is xs = [x | (i, x) <- coppieIndiciXS, notElem i is]
    where
        coppieIndiciXS = zip [0 ..] xs            -- es. [(0, a), (1, c), (2, 3), (3, r), (4, 3)]





-- scrivere una funzione equalsinsamepositions:: Eq a => [a] -> [a] -> [a] che prende due liste
-- di elementi xs e ys, e restituisce una lista zx che contiene coppie (y,x) tali the x=y 
-- e x e y appaiono nella stessa posizione in xs e ys.
-- Esempio: equalsinsamepositions [1, 2, 2] [1, 2, 3, 4] restituisce [1,2]

equalsinsamepositions [] _ = []

equalsinsamepositions _ [] = []

equalsinsamepositions (x:xs) (y:ys)
    | x == y     = x : equalsinsamepositions xs ys
    | otherwise  = equalsinsamepositions xs ys





-- Descrivere il meccanismo di valutazione delle espressioni adottato da Haskell

