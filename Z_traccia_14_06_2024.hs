-- 1) di che tipo è l'espressione map(+1)

-- map(+1):: Num a => [a] -> [a]

-- 2) definire una funzione che data una liste di liste di interi, restituisce una lista in cui l-esimo elemento è la somma dall'i-esima lista

f1:: [[Int]] -> [Int]
f1 = map (\xs -> sum xs)

-- ancora più conciso:
f2:: [[Int]] -> [Int]
f2 = map sum

-- 3) definire una funzione che prende due liste l1 e l2 e restituisce la lista contenente 
-- gli elementi di l1 che non sono presenti in l2
f3:: Eq a => [a] -> [a] -> [a]
f3 [] _ = []
f3 (x:xs) ys
    | x `elem` ys     = f3 xs ys
    | otherwise     = x : f3 xs ys

-- meglio:
f4 xs ys = filter (\x -> x `notElem` ys) xs

-- ancora meglio:
f5 xs ys = filter (`notElem` ys) xs
