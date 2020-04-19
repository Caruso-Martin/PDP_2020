-- Trabajo Prácrico 1: Commerce - Paradigmas de Programacion
-- Fecha de entrega: 13/4
-- Hecho por Martín Caruso

productoCorriente :: String -> Bool --Funciona
productoCorriente nombre 
    | head nombre == 'A' || head nombre == 'a' = True
    | head nombre == 'E' || head nombre == 'e' = True
    | head nombre == 'I' || head nombre == 'i' = True
    | head nombre == 'O' || head nombre == 'o' = True
    | head nombre == 'U' || head nombre == 'u' = True
    | otherwise = False

productoXL :: String -> String --Funciona
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


--DUDA: Porque no puedo tipar cantidad como Int 
--precioTotal :: Float -> Float -> Float -> Float -> Float
--precioTotal precio cantidad descuento costoEnvio =  aplicarDescuento (precio * cantidad) descuento + costoEnvio 


--ESTAN MAL TIPADAD CREO
--take :: Int -> String -> String
--drop :: Int -> String -> String
--head :: String -> Char
--elem :: Char -> String -> Bool 
--reverse :: a -> a
