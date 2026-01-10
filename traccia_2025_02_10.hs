-- Definire in Haskell una funzione che riceve una lista di coppie di numeri interi
-- e restituisce una lista di liste in cui ogni lista corripsondente 
-- ad una coppia (x,k) contiene la sequenza [x, 2*x, ..., k*x]
-- convertiLista:: [(Int,Int)] -> [[Int]] 
-- Esempio: convertilista [(1,3), (2,2)] = [[1,2,3],[2,4]]

convertiLista :: (Eq a, Num a) => [(a, a)] -> [[a]]
convertiLista [] = []
convertiLista ((x, k):xs) = reverse (prod x k) :  convertiLista xs

prod :: (Eq t, Num t) => t -> t -> [t]
prod _ 0 = []
prod x k = k*x : prod x (k-1)

-- versione con List Comprehension:
convertiLista2 :: (Enum a, Num a) => [(a, a)] -> [[a]]
convertiLista2 xs = [ [x*i | i <- [1..k]] | (x, k) <- xs ]

-- soluzione prof:
convertiLista3 :: [(Integer, Integer)] -> [[Integer]]
convertiLista3 = map (\(x, k) -> [x*i | i <- [1..k]])



-- Si consideri il tipo di dati Graph definito come segue.
data Map k a
type Node = Int
type Graph = Map Node [Node]
-- dove su Map è definita la seguente funzione: lookup :: Ord k => k -> Map k a -> Maybe a
-- Implementare una funzione cricca:: [Node] -> Graph -> Bool
-- che restituisce vero se e solo se la lista di nodi passata come primo argomento 
-- è una cricca del grafo passato come secondo argomento
-- Esempio: graph = Map.fromList [ (1, [2, 3]), (2, [1, 3, 4]), (3, [1, 2, 4, 5]), (4, [2, 3]), (5, [3]) ]
--          cricca [1,2,3] graph  = True
--          cricca [1,4] graph = False
-- Si assuma che il grafo sia non orientato come nell'esempio 
-- (se x è nella lista degli adiacenti di y allora y è nella lista degli adiacenti di x)

cricca :: [Node] -> Graph -> Bool
cricca xs g = all (\x -> connesso x xs g) xs

connesso :: Node -> [Node] -> Graph -> Bool
connesso n xs g = 
    case Data.Map.lookup n g of
        Nothing         -> False -- n non è un nodo del grafo
        Just adjListOfN -> all (\x -> x == n || elem x adjListOfN) xs



-- Qual'è il tipo della seguente espressione Haskell? Motivare la risposta.
-- (\f x -> f (f (x*2)))

-- Num a => (a -> a) -> a -> a