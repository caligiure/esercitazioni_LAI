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