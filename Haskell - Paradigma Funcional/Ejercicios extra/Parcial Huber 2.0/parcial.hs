import Text.Show.Functions()

-- Punto 1

data Chofer = Chofer {
    nombreChofer    :: String,
    kilometraje     :: Int,
    viajesTomados   :: [Viaje],
    condiciones     :: [Condicion]
} deriving Show

data Cliente = Cliente {
    nombreCliente   :: String,
    dondeVive       :: String
} deriving Show

data Viaje = Viaje {
    cliente         :: Cliente,
    fecha           :: (Int, Int, Int),
    costo           :: Float
} deriving Show

-- Punto 2

type Condicion = Viaje -> Bool

tomaCualquiera :: Condicion
tomaCualquiera _ = True

viajesDeMasDe200 :: Condicion
viajesDeMasDe200 = (>200) . costo

nombreConMayorLongitudA :: Int -> Condicion
nombreConMayorLongitudA longitud = (>longitud) . length . nombreCliente . cliente 

zonaRestringida :: String -> Condicion
zonaRestringida ubicacion = not . (==ubicacion) . dondeVive . cliente

-- Punto 3

lucas = Cliente {
    nombreCliente   = "Lucas",
    dondeVive       = "Victoria"
}

daniel = Chofer {
    nombreChofer    = "Daniel",
    kilometraje     =  23500,
    viajesTomados   = [viajeD],
    condiciones     = [zonaRestringida "Olivos"]
}

viajeD = Viaje {
    cliente         = lucas,
    fecha           = (20,04,2017),
    costo           = 150
}

alejandra = Chofer {
    nombreChofer    = "Alejandra",
    kilometraje     =  180000,
    viajesTomados   = [],
    condiciones     = [tomaCualquiera]
}

-- Punto 4

juan = Cliente {
    nombreCliente   = "Juan",
    dondeVive       = "Olivos"
}

maria = Cliente {
    nombreCliente   = "Maria",
    dondeVive       = "Lanus"
}

viajeA = Viaje {
    cliente         = juan,
    fecha           = (20,04,2017),
    costo           = 232
}

viajeB = Viaje {
    cliente         = maria,
    fecha           = (20,04,2017),
    costo           = 200
}

viajeC = Viaje {
    cliente         = lucas,
    fecha           = (20,04,2017),
    costo           = 150
}

lautaro = Chofer {
    nombreChofer    = "Lautaro",
    kilometraje     =  180000,
    viajesTomados   = [viajeA, viajeB],
    condiciones     = [nombreConMayorLongitudA 4]
}

pedro = Chofer {
    nombreChofer    = "Pedro",
    kilometraje     =  180000,
    viajesTomados   = [],
    condiciones     = [viajesDeMasDe200]
}

tomaViaje chofer viaje = 
    foldl1 (&&) (map ($ viaje) (condiciones chofer))

-- Punto 5

liquidacion = sum . map costo . viajesTomados 

-- Punto 6

remiseriaA = [pedro, lautaro, alejandra, daniel]
remiseriaB = [lautaro, alejandra, daniel]
remiseriaC = [pedro, lautaro, alejandra]

quienesTomanViaje viaje listaChoferes =
    filter (\c -> tomaViaje c viaje) listaChoferes


-- Punto 7

repetirViaje viaje = viaje : repetirViaje viaje

nitoInfy = Chofer {
    nombreChofer    = "Nito Infy",
    kilometraje     =  70000,
    viajesTomados   = (repetirViaje viajeA),
    condiciones     = [nombreConMayorLongitudA 2]
}

-- B. No se puede.
-- C. Si se puede.

-- Punto 8
gongNeng :: Ord c => c -> (c -> Bool) -> (a -> c) -> [a] -> c
gongNeng arg1 arg2 arg3 = 
     max arg1 . head . filter arg2 . map arg3

