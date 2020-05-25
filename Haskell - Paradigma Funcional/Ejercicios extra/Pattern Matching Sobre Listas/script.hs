tomarN :: Integer -> [a] -> [a] 
tomarN _ [] = []
tomarN n _  | n <= 0  = [] 
tomarN n (x:xs) = x : tomarN (n - 1) xs 

----

sumaDeListas :: [Integer] -> [Integer] -> [Integer]
sumaDeListas (x:xs) (y:ys)
  | length xs > length ys = (zipWith (+) (x:xs) (y:ys)) ++ drop (length ys) xs
  | length xs < length ys = (zipWith (+) (x:xs) (y:ys)) ++ drop (length xs) ys
  | otherwise = zipWith (+) (x:xs) (y:ys) 

----

unoMasDosIgualTres :: [Integer] -> Bool
unoMasDosIgualTres (x:y:z:_) = x + y == z 

----

--listasIguales :: [a] -> [a] -> Bool
--listasIguales (x:xs) (y:ys) =

----

--cantidadDeApariciones :: a -> [a] -> Integer
--cantidadDeApariciones elemento lista = length (filter (== elemento) lista)

repetirPalabras nombre = nombre : repetirPalabras nombre ++ show (foldl1 (+) (take 1 (iterate (\x -> x + 1) 1)))