-- qual è il tipo dell'espressione: filter(f) dove f è definita come: f(x,y) = x^y == y^x
-- NB si ricorda che il tipo di (^) è: (^) :: (Num a, Integral b) => a -> b -> a

-- f :: Integral a => (a, a) -> Bool
-- filter :: (a -> Bool) -> [a] -> [a]
-- filter f :: Integral a => [(a, a)] -> [(a, a)]



-- definire la funzione: gruppik:: Int->[a]->[[a]]
-- che, dato un intero k e una lista xs, restituisce tutte le sottoliste di xs 
-- di lunghezza esattamente k non sovrapposte (cioè ogni sottolista inizia 
-- subito dopo la precedente e la prima inizia con il primo elemento)
-- esempio: gruppik 2 [1,2,3,4,5] —>[[1,2],[3,4]]

gruppik :: Int -> [a] -> [[a]]
gruppik k xs
    | k <= 0            = []
    | k <= length xs    = take k xs : gruppik k (drop k xs)
    | otherwise         = []



-- scrivere una funzione che prende in input un intero x e una lista di interi xs, 
-- e restituisce una lista xs in cui viene mantenuta solo l'ultima occorrenza di x, 
-- eliminando tutte le altre. L'ordine degli altri elementi deve essere mantenuto.
-- KeepLast :: Int ->[Int] ->[Int]
-- keepLast 1 [2,1,3,1,4,1,6] ->[2,3,4,1,6]

keepLast :: Eq a => a -> [a] -> [a]
keepLast _ [] = []
keepLast k (x:xs)
    | k /= x                    = x : keepLast k xs
    | k == x && notElem k xs    = x:xs
    | otherwise                 = keepLast k xs

keepLastEfficient :: Eq a => a -> [a] -> [a]
keepLastEfficient k xs = reverse (keepFirst k (reverse xs))

keepFirst :: Eq a => a -> [a] -> [a]
keepFirst _ [] = []
keepFirst k (x:xs)
    | k /= x                    = x : keepFirst k xs
    | otherwise                 = x : filter (/= k) xs
