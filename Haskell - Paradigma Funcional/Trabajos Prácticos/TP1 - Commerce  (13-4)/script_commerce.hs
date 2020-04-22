-- Trabajo Prácrico 1: Commerce - Paradigmas de Programacion
-- Fecha de entrega: ??/04
-- Hecho por Martín Caruso

productoCorriente :: String -> Bool 
productoCorriente nombre  
    | head nombre == 'A' || head nombre == 'a' = True
    | head nombre == 'E' || head nombre == 'e' = True
    | head nombre == 'I' || head nombre == 'i' = True
    | head nombre == 'O' || head nombre == 'o' = True
    | head nombre == 'U' || head nombre == 'u' = True
    | otherwise = False

productoXL :: String -> String 
productoXL nombre = nombre ++ " XL"
  
productoCodiciado :: String -> Bool 
productoCodiciado nombre = length nombre >= 10

descodiciarProducto :: String -> String 
descodiciarProducto nombre 
    | productoCodiciado nombre = take 10 nombre
    | otherwise = nombre 

aplicarCostoEnvio :: Float -> Float -> Float
aplicarCostoEnvio precio costoEnvio = precio + costoEnvio 

entregaSencilla :: String -> Bool
entregaSencilla = even.length  

versionBarata :: String -> String
versionBarata = reverse.descodiciarProducto

productoDeLujo :: String -> Bool
productoDeLujo nombre = elem 'x' nombre || elem 'z' nombre

aplicarDescuento :: Float -> Float -> Float
aplicarDescuento precio descuento = precio - precio * descuento / 100  

productoDeElite :: String -> Bool
productoDeElite nombre = productoDeLujo nombre && productoCodiciado nombre && not (productoCorriente nombre)

--Reemplazar Float con Int funciona 
precioTotal :: Int -> Float -> Float -> Float -> Float
precioTotal cantidad precio descuento costoEnvio = aplicarCostoEnvio (aplicarDescuento precio descuento * fromIntegral(cantidad)) costoEnvio   

--FUNCIONES UTILES (SOLO TIPADAS)
--take :: Int -> [a] -> [a]
--drop :: Int -> [a] -> [a]
--head :: [a] -> a
--elem :: Eq => a -> [a] -> Bool
--reverse :: [a] -> [a]
--[a] se refiere a listas, como String o una lista de numeros

--DUDAS
--  Es necesario que definamos las funciones del final, o las dejamos como comentarios?