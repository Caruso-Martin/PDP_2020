-- Trabajo Práctico 1: Commerce - Paradigmas de Programacion
-- Hecho por Martín Caruso

type Producto = String

-- Trata de resolver esto usando composición
productoCorriente :: Producto -> Bool 
productoCorriente nombre  = ((== 'A').head) nombre ||  ((== 'E').head) nombre || ((== 'I').head) nombre ||  ((== 'O').head) nombre || ((== 'U').head) nombre ||  ((== 'a').head) nombre || ((== 'e').head) nombre ||  ((== 'i').head) nombre || ((== 'o').head) nombre ||  ((== 'u').head) nombre
    
-- productoCorriente "Ariel"      -> True
-- productoCorriente "escuadra"   -> True
-- productoCorriente "Iman"       -> True
-- productoCorriente "olla"       -> True
-- productoCorriente "Ukelele"    -> True
-- productoCorriente "Heladera"   -> False

--Perfecto!
productoXL :: Producto -> Producto --Cambie el tipo
productoXL nombre = nombre ++ " XL"
  
-- productoXL "Heladera"    -> "Heladera XL"

--Intenta resolverlo con una composición
productoCodiciado :: Producto -> Bool 
productoCodiciado = (> 10).length  

-- productoCodiciado "Heladera XL"  -> True
-- productoCodiciado "Heladera"     -> False
-- productoCodiciado "Heladera Z"   -> False

--Si a take le pasas un número mayor a la longitud del string te retorna todo el string, no es necesario la guarda.
descodiciarProducto :: Producto -> Producto 
descodiciarProducto = take 10 

-- descodiciarProducto "Heladera XL"  -> "Heladera X"
-- descodiciarProducto "Heladera"     -> "Heladera"   
-- descodiciarProducto "Heladera Z"   -> "Heladera Z" 


--Podrías decir que aplicarCostoEnvio es la suma.
aplicarCostoEnvio :: Num a => a -> a -> a
aplicarCostoEnvio = (+)

-- aplicarCostoEnvio 10.1 5.2   -> 15.3

--Muy bien!
entregaSencilla :: Producto -> Bool --Cambie el tipo
entregaSencilla = even.length  

-- entregaSencilla "Heladera XL"  -> False
-- entregaSencilla "Heladera"     -> True
-- entregaSencilla "Heladera Z"   -> True

--OK! (aunque no estoy seguro de cual es el orden correcto, pero no importa)
versionBarata :: Producto -> Producto --Cambie el tipo
versionBarata = reverse.descodiciarProducto

-- versionBarata "Heladera XL"  -> "LX aredaleH"
-- versionBarata "Heladera"     -> "aredaleH"   
-- versionBarata "Heladera Z"   -> "Z aredaleH" 

--OK!
productoDeLujo :: Producto -> Bool
productoDeLujo nombre = elem 'x' nombre || elem 'z' nombre || elem 'X' nombre || elem 'Z' nombre

-- productoDeLujo "Heladera XL"  -> True
-- productoDeLujo "Heladera"     -> False
-- productoDeLujo "Heladera Z"   -> True

--OK! (Podes sacar factor común precio, pero no hace falta)
aplicarDescuento :: Float -> Float -> Float
aplicarDescuento precio descuento = precio * (1 - descuento / 100) 

-- aplicarDescuento 300.0 15.0  -> 255.0

--También podrías hacer una composición entre not y productoCorriente
productoDeElite :: Producto -> Bool
productoDeElite nombre = productoDeLujo nombre && productoCodiciado nombre && (not.productoCorriente) nombre

-- productoDeElite "Pad Pro Mini XL"    -> True
-- productoDeElite "iPad Pro Mini XL"   -> False

-- productoDeElite "Heladera XL"        -> True
-- productoDeElite "Heladera X"         -> False

-- productoDeElite "Sillon verde XL"    -> True
-- productoDeElite "Sillon verde SL"    -> False

--Podes simplificar la variable costoEnvio. 
precioTotal :: Int -> Float -> Float -> Float -> Float
precioTotal cantidad precio descuento costoEnvio = costoEnvio + aplicarDescuento precio descuento * fromIntegral(cantidad)     

-- precioTotal 10 200.5 15.3 400.99 -> 2099.225

--FUNCIONES UTILES (SOLO TIPADAS)
--take :: Int -> [a] -> [a]
--drop :: Int -> [a] -> [a]
--head :: [a] -> a
--elem :: Eq => a -> [a] -> Bool
--reverse :: [a] -> [a]
--[a] se refiere a listas, como String o una lista de numeros


