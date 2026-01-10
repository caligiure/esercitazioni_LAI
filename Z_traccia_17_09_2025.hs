-- Definire in Haskell una funzione che riceve una lista di liste di numeri XSS 
-- e restituisce una lista YS che contiene per ogni lista XS che appare in XSS 
-- l'elemento maggiore YS. se XSS è vuota si dovrá restituire una lista vuota.

-- convertiLista:: Int -> [[Num]] -> [Num]

-- Esempio: convertilista [[1,2,3],[4,5]] = [3,5]

convertiLista:: [[Int]] -> [Int]
convertiLista [] = []
convertiLista (xs:xss) = massimo xs : convertiLista xss

-- più bello:
convertiLista2 :: (Num b, Ord b) => [[b]] -> [b]
convertiLista2 = map massimo

massimo :: Ord a => [a] -> a
massimo [x] = x
massimo (x:xs)
    | x >= maxInXS      = x
    | otherwise         = maxInXS
    where
        maxInXS = massimo xs

-- alternativa usando la funzione max (in prelude)
massimo2 :: Ord a => [a] -> a
massimo2 [x] = x
massimo2 (x:xs) = max x (massimo2 xs)

-- versione che gestisce la lista vuota e usa max
massimo3 :: Ord a => [a] -> Maybe a
massimo3 [] = Nothing
massimo3 (x:xs) =
    case massimo3 xs of
        Nothing -> Just x
        Just m -> Just (max x m)

-- versione che gestisce la lista vuota e usa maximum
massimo4 [] = Nothing
massimo4 xs = Just (maximum xs)



-- Definire una funzione haskell che ricevuta in input una lista di interi 
-- restituisce una lista di liste contenente tutte le permutazioni della lista in input

-- permutazioni:: [Int] ->[[Int]]

-- permutazioni [1,2,3] = [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]

-- soluzione con List Comprehension
permutazioni:: [Int] ->[[Int]]
permutazioni [] = [[]]
permutazioni xs = [x:ys | x <- xs, ys <- permutazioni (rimuovi x xs)]

rimuovi :: Eq t => t -> [t] -> [t]
rimuovi _ [] = []
rimuovi x (y:ys)
    | x==y          = ys
    | otherwise     = y : rimuovi x ys



-- Descrivere il meccanismo di valutazione delle espressioni adottato da Haskell

-- Haskell adotta la lazy evaluation: outermost evaluation + sharing of arguments
-- La valutazione outermost consiste nel valutare per prima la redex (reducible expression) 
-- più esterna (che non è contenuta in nessun'altra redex)
-- In questo modo le espressioni non vengono valutate appena vengono incontrate, 
-- ma solo quando il loro risultato è strettamente necessario per il proseguimento del calcolo.
-- La outermost evaluation assicura che la valutazione termini sempre, 
-- se esiste una sequenza di valutazione che lo consente, e inoltre non richiede mai
-- più step di quanti ne avrebbe richiesti la innermost evaluation.
-- sharing of arguments consiste nel condividere gli argomenti di una funzione già calcolati, tramite
-- dei puntatori alle aree di memoria in cui sono stati conservati, in modo da evitare
-- di doverli caloclare più volte.
-- I vantaggi della lazy evaluation sono:
-- Efficienza: Evita calcoli non necessari valutando solo quanto richiesto dal contesto.
-- Strutture Infinite: Supporta la programmazione con liste infinite, poiché i dati sono generati solo se consumati.
-- Modularità: Permette di separare nettamente la logica di generazione dei dati (data part) da quella di controllo (control part).