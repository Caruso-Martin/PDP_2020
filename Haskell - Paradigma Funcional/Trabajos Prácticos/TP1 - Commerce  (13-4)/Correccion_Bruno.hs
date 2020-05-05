-- Trabajo Prácrico 1: Commerce - Paradigmas de Programacion
-- Hecho por Martín Caruso

-- Recorda lo que vimos en la clase, es redundante devolver True o False según se cumpla o no una condición, retorna directamente la condición
--Un ejemplo boludo de esto puede ser

{-
esPositivo x 
 |x > 0 = True
 |otherwise = False

 en lugar de

 esPositivo = (>0)
-}

 
-- Trata de resolver esto usando composición

productoCorriente :: String -> Bool 
productoCorriente nombre  
    | head nombre == 'A' || head nombre == 'a' = True
    | head nombre == 'E' || head nombre == 'e' = True
    | head nombre == 'I' || head nombre == 'i' = True
    | head nombre == 'O' || head nombre == 'o' = True
    | head nombre == 'U' || head nombre == 'u' = True
    | otherwise = False

-- productoCorriente "Ariel"      -> True
-- productoCorriente "escuadra"   -> True
-- productoCorriente "Iman"       -> True
-- productoCorriente "olla"       -> True
-- productoCorriente "Ukelele     -> True
-- productoCorriente "Heladera"   -> False


--Perfecto!
productoXL :: String -> String 
productoXL nombre = nombre ++ " XL"
  
-- productoXL "Heladera"    -> "Heladera XL"

--Intenta resolverlo con una composición
productoCodiciado :: String -> Bool 
productoCodiciado nombre = length nombre > 10

-- productoCodiciado "Heladera XL"  -> True
-- productoCodiciado "Heladera"     -> False
-- productoCodiciado "Heladera Z"   -> False

--Si a take le pasas un número mayor a la longitud del string te retorna todo el string, no es necesario la guarda.
descodiciarProducto :: String -> String 
descodiciarProducto nombre 
    | productoCodiciado nombre = take 10 nombre
    | otherwise = nombre 

-- descodiciarProducto "Heladera XL"  -> "Heladera X"
-- descodiciarProducto "Heladera"     -> "Heladera"   
-- descodiciarProducto "Heladera Z"   -> "Heladera Z" 


--Podrías decir que aplicarCostoEnvio es la suma.
aplicarCostoEnvio :: Float -> Float -> Float
aplicarCostoEnvio precio costoEnvio = precio + costoEnvio 

-- aplicarCostoEnvio 10.1 5.2   -> 15.3

--Muy bien!
entregaSencilla :: String -> Bool
entregaSencilla = even.length  

-- entregaSencilla "Heladera XL"  -> False
-- entregaSencilla "Heladera"     -> True
-- entregaSencilla "Heladera Z"   -> True

--OK! (aunque no estoy seguro de cual es el orden correcto, pero no importa)
versionBarata :: String -> String
versionBarata = reverse.descodiciarProducto

-- versionBarata "Heladera XL"  -> "LX aredaleH"
-- versionBarata "Heladera"     -> "aredaleH"   
-- versionBarata "Heladera Z"   -> "Z aredaleH" 

--OK!
productoDeLujo :: String -> Bool
productoDeLujo nombre = elem 'x' nombre || elem 'z' nombre || elem 'X' nombre || elem 'Z' nombre

-- productoDeLujo "Heladera XL"  -> True
-- productoDeLujo "Heladera"     -> False
-- productoDeLujo "Heladera Z"   -> True

--OK! (Podes sacar factor común precio, pero no hace falta)
aplicarDescuento :: Float -> Float -> Float
aplicarDescuento precio descuento = precio - precio * descuento / 100  

-- aplicarDescuento 300.0 15.0  -> 255.0

--También podrías hacer una composición entre not y productoCorriente
productoDeElite :: String -> Bool
productoDeElite nombre = productoDeLujo nombre && productoCodiciado nombre && not (productoCorriente nombre)

-- productoDeElite "Pad Pro Mini XL"    -> True
-- productoDeElite "iPad Pro Mini XL"   -> False

-- productoDeElite "Heladera XL"        -> True
-- productoDeElite "Heladera X"         -> False

-- productoDeElite "Sillon verde XL"    -> True
-- productoDeElite "Sillon verde SL"    -> False

--Podes simplificar la variable costoEnvio.
precioTotal :: Int -> Float -> Float -> Float -> Float
precioTotal cantidad precio descuento costoEnvio = aplicarCostoEnvio (aplicarDescuento precio descuento * fromIntegral(cantidad)) costoEnvio   

-- precioTotal 10 200.5 15.3 400.99 -> 2099.225

--FUNCIONES UTILES (SOLO TIPADAS)
--take :: Int -> [a] -> [a]
--drop :: Int -> [a] -> [a]
--head :: [a] -> a
--elem :: Eq => a -> [a] -> Bool
--reverse :: [a] -> [a]
--[a] se refiere a listas, como String o una lista de numeros



--No sé si lo vimos antes de que les dieramos el tp, pero en haskell se pueden definir alias de tipos, por ejemplo

type Producto = String

--Esto aumenta la expresividad del código y es más útil cuando se tienen tipos más complejos, por ejemplo tuplas.