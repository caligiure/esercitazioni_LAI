-- Definire una funzione subsetsum che prende in input un intero x 
-- e una lista di interi s e restituisce una lista contenente tutte 
-- le sottoliste s1 di s tali che la somma degli elementi di s1 è uguale a x

-- Esempi:

-- subsetsum 10 [2, -1, 4, 5, 3, 6, 1] == [[3,6,1],[4,6],[4,5,1],[-1,5,6],
-- [-1,4,6,1],[2,5,3],[2,4,3,1],[2,-1,3,6],[2,-1,5,3,1],[2,-1,4,5]]

-- subsetsum 10 [2, -1, 4, 3] == [ ]

subsequences :: [a] -> [[a]]
subsequences [] = [[]]
subsequences (x:xs) = subsequences xs ++ map (x:) (subsequences xs)

subsetsum :: Int -> [Int] -> [[Int]]
subsetsum x s = filter (\sub -> sum sub == x) (subsequences s)



-- Si considere il tipo data AlberoBInt = Vuoto | Nodo Int AlberoBInt AlberoBInt
-- Scrivere una funzione pathtutto x a che restituisce vero se esiste un 
-- nodo foglia di a tale che il cammino dalla radice verso questo nodo 
-- foglia è composto da nodi che hanno tutti valore x.

-- Esempio
-- Si considerino:
-- albero1 = Nodo 1 (Nodo 1 Vuota Vuota) (Nodo 3 Vuota Vuota) 
-- albero2 = Vuota 
-- albero3 = Nodo 1 (Nodo 5 Vuota Vuota) (Nodo 1 (Nodo 7 Vuota Vuota) Vuota)

-- pathtutto 1 albero1 = true
-- pathtutto 1 albero2 =  false
-- pathtutto 1 albero3 = false

data AlberoBInt = Vuoto | Nodo Int AlberoBInt AlberoBInt deriving (Eq)

pathtutto :: Int -> AlberoBInt -> Bool
pathtutto _ Vuoto = False
pathtutto x (Nodo v sx dx)
    | x /= v    = False
    | x == v && sx==Vuoto && dx==Vuoto  = True
    | otherwise     = pathtutto x sx || pathtutto x dx


-- Qual'è il tipo dell'espressione seguente?
-- (\x -> x + 1)
-- Motivare la risposta.

--Num a => a -> a
-- Perchè l'operatore + può essere applicato solo su tipi numerici.