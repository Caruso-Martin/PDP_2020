-- Trabajo Prácrico 1: Commerce - Paradigmas de Programacion
-- Hecho por Martín Caruso

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

productoXL :: String -> String 
productoXL nombre = nombre ++ " XL"
  
-- productoXL "Heladera"    -> "Heladera XL"

productoCodiciado :: String -> Bool 
productoCodiciado nombre = length nombre > 10

-- productoCodiciado "Heladera XL"  -> True
-- productoCodiciado "Heladera"     -> False
-- productoCodiciado "Heladera Z"   -> False

descodiciarProducto :: String -> String 
descodiciarProducto nombre 
    | productoCodiciado nombre = take 10 nombre
    | otherwise = nombre 

-- descodiciarProducto "Heladera XL"  -> "Heladera X"
-- descodiciarProducto "Heladera"     -> "Heladera"   
-- descodiciarProducto "Heladera Z"   -> "Heladera Z" 

aplicarCostoEnvio :: Float -> Float -> Float
aplicarCostoEnvio precio costoEnvio = precio + costoEnvio 

-- aplicarCostoEnvio 10.1 5.2   -> 15.3

entregaSencilla :: String -> Bool
entregaSencilla = even.length  

-- entregaSencilla "Heladera XL"  -> False
-- entregaSencilla "Heladera"     -> True
-- entregaSencilla "Heladera Z"   -> True

versionBarata :: String -> String
versionBarata = reverse.descodiciarProducto

-- versionBarata "Heladera XL"  -> "LX aredaleH"
-- versionBarata "Heladera"     -> "aredaleH"   
-- versionBarata "Heladera Z"   -> "Z aredaleH" 

productoDeLujo :: String -> Bool
productoDeLujo nombre = elem 'x' nombre || elem 'z' nombre || elem 'X' nombre || elem 'Z' nombre

-- productoDeLujo "Heladera XL"  -> True
-- productoDeLujo "Heladera"     -> False
-- productoDeLujo "Heladera Z"   -> True

aplicarDescuento :: Float -> Float -> Float
aplicarDescuento precio descuento = precio - precio * descuento / 100  

-- aplicarDescuento 300.0 15.0  -> 255.0

productoDeElite :: String -> Bool
productoDeElite nombre = productoDeLujo nombre && productoCodiciado nombre && not (productoCorriente nombre)

-- productoDeElite "Pad Pro Mini XL"    -> True
-- productoDeElite "iPad Pro Mini XL"   -> False

-- productoDeElite "Heladera XL"        -> True
-- productoDeElite "Heladera X"         -> False

-- productoDeElite "Sillon verde XL"    -> True
-- productoDeElite "Sillon verde SL"    -> False

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
