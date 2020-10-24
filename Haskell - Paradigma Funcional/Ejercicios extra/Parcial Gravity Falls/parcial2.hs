import Text.Show.Functions()
-- Primera parte: Rarezas

-- Punto 1

data Persona = Persona {
    edad            :: Int,
    experiencia     :: Int,
    items           :: [String]
} deriving (Eq, Show)

data Criatura = Criatura {
    peligrosidad        :: Int,
    categoriaOCantidad  :: Int,
    condiciones         :: [Condicion]
} deriving Show

--- Condiciones
type Condicion = Persona -> Bool

noSePuedeGanar :: Condicion
noSePuedeGanar _ = False

poseeItem :: String -> Condicion
poseeItem item = any (==item) . items

tieneMenosDe :: Int -> Condicion
tieneMenosDe anios = (<anios) . edad

tieneMasXPQue :: Int -> Condicion
tieneMasXPQue cantidad = (>cantidad) . experiencia 

--- Criaturas

siempreDetras = Criatura {
    peligrosidad        = 0,
    categoriaOCantidad  = 1,
    condiciones         = [noSePuedeGanar]
} 

gnomos10 = Criatura {
    peligrosidad        = 2 ^ (categoriaOCantidad gnomos10),
    categoriaOCantidad  = 10,
    condiciones         = [poseeItem "soplador de hojas"]
} 

fantasma1 = Criatura {
    peligrosidad        = 20 * categoriaOCantidad fantasma1,
    categoriaOCantidad  = 1,
    condiciones         = [tieneMasXPQue 10]
} 

fantasma3 = Criatura {
    peligrosidad        = 20 * categoriaOCantidad fantasma1,
    categoriaOCantidad  = 3,
    condiciones         = [tieneMenosDe 13, poseeItem "disfraz de oveja"]
}

--- Personas

dipper = Persona {
    edad            = 14,
    experiencia     = 35,
    items           = ["soplador de hojas"]
}

mabel = Persona {
    edad            = 14,
    experiencia     = 36,
    items           = ["disfraz de oveja"]
}

pacifica = Persona {
    edad            = 12,
    experiencia     = 9,
    items           = ["disfraz de oveja", "soplador de hojas"]
}


-- Punto 2 

xpGanada :: Int -> Persona -> Persona
xpGanada cantidadXPGanada persona = persona {experiencia = ((+cantidadXPGanada) . experiencia) persona}

ganaPelea criatura persona = foldl1 (&&) (map ($ persona) (condiciones criatura))


enfrentamiento :: Criatura -> Persona -> Persona
enfrentamiento criatura persona 
    | ganaPelea criatura persona = xpGanada (peligrosidad criatura) persona
    | otherwise = xpGanada 1 persona
        

-- Punto 3
{-
variosEnfrentamientos [] persona = 0

variosEnfrentamientos (c : cs) persona 
    | ganaPelea c persona = peligrosidad c + variosEnfrentamientos cs 
    | otherwise = 1 + variosEnfrentamientos cs
-}

-- Parte 2: Mensajes ocultos

-- Punto 1
zipWithIf :: (a -> b -> b) -> (b -> Bool) -> [a] -> [b] -> [b] 
zipWithIf _ _ _ [] = []
zipWithIf _ _ [] _ = []
zipWithIf funcion condicion (x : xs) (y : ys) 
    | condicion y = (funcion x y) : zipWithIf funcion condicion xs ys 
    | otherwise = y : zipWithIf funcion condicion (x : xs) ys

-- Punto 2

abecedarioDesde :: Char -> [Char]
abecedarioDesde letra = take 26 ((enumFromTo letra 'z') ++ (enumFromTo 'a' letra)) 

desencriptarLetra alfa aDesencriptar = 

-- Punto 3    
