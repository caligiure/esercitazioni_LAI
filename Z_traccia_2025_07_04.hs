-- Definire in Haskell una funzione che riceve una lista di liste di numeri XSS 
-- e restituisce una lista YS che contiene per ogni lista XS che appare in XSS 
-- l'elemento maggiore YS. se XSS è vuota si dovrá restituire una lista vuota.
-- convertiLista:: Int -> [[Num]] -> [Num]
-- Esempio: convertilista [[1,2,3],[4,5]] = [3,5]

convertiLista:: (Num a, Ord a) => [[a]] -> [a]
convertiLista = map maggiore

maggiore :: Ord a => [a] -> a
maggiore [x] = x
maggiore (x:y:ys)
    | x >= y    = maggiore (x:ys)
    | otherwise = maggiore (y:ys)

maggiore2 :: Ord a => [a] -> a
maggiore2 [x] = x
maggiore2 (x:xs)
    | x >= maxElem    = x
    | otherwise       = maxElem
    where
        maxElem = maggiore xs

maggiore3 :: Ord a => [a] -> a
maggiore3 = foldr1 max
-- Nota: foldr richiederebbe obbligatoriamente un valore iniziale (l'accumulatore per il caso base)
-- foldr prende 3 cose: una funzione, un valore iniziale, e la lista
-- foldr1 prende 2 cose: una funzione e la lista (usa l'ultimo elemento come valore iniziale)



-- Si consideri il tipo di dati
data BoolExpr = MioTrue | MioFalse | MioAnd BoolExpr BoolExpr  | MioOr BoolExpr BoolExpr | MioNot BoolExpr
-- Si definisca la funzione:    eval :: Expr -> Bool
-- che restituisce il valore di veritá ottenuto dalla valutazione dell’espressione, 
-- dove MioAnd, MioOr, MioNot, MioTrue e MioFalse sono da interpretarsi come i 
-- corrispondenti valori o operatori booleani
-- Esempio:     evalBoolExpr (MioAnd MioTrue (MioOr MioFalse (MioNot MioTrue)))     è uguale a False

eval :: BoolExpr -> Bool
eval MioTrue = True
eval MioFalse = False
eval (MioAnd expr1 expr2) = eval expr1 && eval expr2
eval (MioOr expr1 expr2) = eval expr1 || eval expr2
eval (MioNot expr) = not (eval expr)

-- Nota: il tipo BoolExpr crea quello che in informatica si chiama Abstract Syntax Tree (AST),
-- la funzione eval esegue una visita di questo albero



-- Qual è il tipo della funzione twice definita nel seguente modo
-- twice f x = f (f x)
-- Motivare la risposta

twice :: (t -> t) -> t -> t
twice f x = f (f x)

-- Poniamo che sia:     x :: t
-- Notiamo che f (f x) implica che l'output della funzione f sia dello stesso tipo del suo input
-- cioè:    f :: t -> t
-- Quindi, la funzione twice riceve in input la funzione f, che ha tipo (t -> t),
-- poi riceve in input x, che ha tipo t per ipotesi,
-- infine produce in output il risultato di f (f x), che è di tipo t
-- quindi twice :: (t -> t) -> t -> t
-- dove il primo membro è il tipo di f, il secondo membro è il tipo di x, e il terzo è il tipo di f (f x)