-- date due liste, restituisci gli elementi che appaiono in una sola delle due liste

f:: Eq a => [a] -> [a] -> [a]
f xs ys = f2 xs ys ++ f2 ys xs

f2:: Eq a => [a] -> [a] -> [a]
f2 (x:xs) ys
    | x `elem` ys     = f2 xs ys
    | otherwise       = x : f2 xs ys

-- oppure direttamente con la filter:
f3 :: Eq a => [a] -> [a] -> [a]
f3 xs ys = filter (`notElem` ys) xs ++ filter (`notElem` xs) ys



