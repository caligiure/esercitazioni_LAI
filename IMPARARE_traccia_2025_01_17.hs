-- Definire in Haskell una funzione che riceve una lista di liste di numeri 
-- e restituisce una lista di tuple in cui ogni tupla contiene la somma, 
-- il numero degli elementi e la media della corrispondente lista nella lista di liste in input
-- convertiLista:: Int -> [[Num]] -> [(Num, Int, Num)]
-- Esempio: convertilista [[1,2,3],[4,5]] = [(6,3,2),(9,2,4.5)]

convertiLista:: Num a => [[a]] -> [(a, Int, a)]
convertiLista = map (\ xs -> (sum xs, length xs, sum xs / length xs ))



-- Definire una funzione haskell che ricevuta in input una lista di interi restituisce una lista 
-- di liste contenente tutte le permutazioni della lista in input
-- permutazioni:: [Int] ->[[Int]]
-- permutazioni [1,2,3] = [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]

permutazioni :: Eq a => [a] -> [[a]]
permutazioni [] = [[]]
permutazioni xs = [x:ps | x <- xs, ps <- permutazioni (rimuovi x xs)]
    where 
        rimuovi _ [] = []
        rimuovi x (y:ys)
            | x == y    = ys
            | otherwise = y : rimuovi x ys



-- Qual'è il tipo della seguente espressione HAskell? Motivare la risposta.

-- (\f x -> f (f x))
f3 :: (t -> t) -> t -> t
f3 f4 x = f4 (f4 x)


-- map:: (x -> y) -> [x] -> [y]
-- filter:: (a -> Bool) -> [a] -> [a]
-- map filter:: [(a -> Bool)] -> [[a] -> [a]]
f :: [a -> Bool] -> [[a] -> [a]]
f = map filter

-- map map:: [(x -> y)] -> [[x] -> [y]]
f2 :: [a -> b] -> [[a] -> [b]]
f2 = map map