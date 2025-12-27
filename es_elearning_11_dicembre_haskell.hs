-- Definire in Haskell una funzione che riceve una lista di coppie di numeri 
-- interi e restituisce una lista di liste in cui ogni lista corripsondente 
-- ad una coppia (x,k) contiene la sequenza [x, 2*x, ..., k*x]

-- Esempio: convertilista [(1,3), (2,2)] = [[1,2,3],[2,4]]

convertiLista:: [(Int,Int)] -> [[Int]]
convertiLista[] = []
convertiLista( (n,k) : ls) = prodlist (n,k):convertiLista ls

prodlist:: (Int, Int) -> [Int]
prodlist (n,1) = [n]
prodlist (n,0) = []
prodlist (n,k) = prodlist (n,k-1) ++ [n*k]

convertiLista2 = map (\x k -> [x*n | n <- [1 .. k]])

convertiListaProf:: [(Int,Int)] -> [[Int]]
convertiListaProf = map (\(x,k) -> [x*n | n <- [1 .. k]])



--Si consideri il tipo di dati Graph definito come segue.
data Map k a
type Node = Int
type Graph = Map Node [Node]
--dove su Map è definita la seguente funzione: lookup :: Ord k => k -> Map k a -> Maybe a
--Implementare una funzione cricca:: [Node] -> Graph -> Bool
--che restituisce vero se e solo se la lista di nodi passata come primo argomento è una cricca del grafo 
--passato come secondo argomento
--Esempio
--graph = Map.fromList [ (1, [2, 3]), (2, [1, 3, 4]), (3, [1, 2, 4, 5]), (4, [2, 3]), (5, [3]) ]
--cricca [1,2,3] graph  = True
--cricca [1,4] graph = False
--Si assuma che il grafo sia non orientato come nell'esempio (se x è nella lista degli adiacenti 
--di y allora y è nella lista degli adiacenti di x)

cricca1:: [Node] -> Graph -> Bool
cricca1 nodelist g = all (\n -> nodeIsAdjTo n nodelist g) nodelist

nodeIsAdjTo:: Node -> [Node] -> Graph -> Bool
nodeIsAdjTo n criccaNodes g = 
    case Data.Map.lookup n g of -- restituisce la lista dei nodi adiacenti a n
        Nothing -> False -- n non è un nodo del grafo
        Just adjListOfn -> all (\nodeOfCricca -> nodeOfCricca == n || elem nodeOfCricca adjListOfn) criccaNodes

cricca:: [Node] -> Graph -> Bool
cricca ns g = all(\u -> isCliqueNode u ns g) ns

isCliqueNode u ns g =
    case Data.Map.lookup u g of
        Nothing     -> False    -- nodo assente dal grafo
        Just adjList ->
            all (\v -> v == u || v `elem` adjList) ns



-- Qual'è il tipo della seguente espressione Haskell? Motivare la risposta.

-- (\f x -> f (f (x*2)))

-- Num t => (t -> t) -> t-> t