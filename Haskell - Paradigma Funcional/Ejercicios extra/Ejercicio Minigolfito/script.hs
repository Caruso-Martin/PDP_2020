import Text.Show.Functions()

data Jugador = UnJugador {
  nombre :: String,
  padre :: String,
  habilidad :: Habilidad
} deriving (Eq, Show)

data Habilidad = Habilidad {
  fuerzaJugador :: Int,
  precisionJugador :: Int
} deriving (Eq, Show)

-- Jugadores de ejemplo
bart :: Jugador
bart = UnJugador "Bart" "Homero" (Habilidad 25 60)

todd :: Jugador
todd = UnJugador "Todd" "Ned" (Habilidad 15 80)

rafa :: Jugador
rafa = UnJugador "Rafa" "Gorgory" (Habilidad 10 1)

data Tiro = UnTiro {
  velocidad :: Int,
  precision :: Int,
  altura :: Int
} deriving (Eq, Show)

type Puntos = Int

-- Funciones útiles
between :: (Eq a, Enum a) => a -> a -> a -> Bool
between n m x = elem x [n .. m]

maximoSegun :: (Foldable t, Ord a1) => (a2 -> a1) -> t a2 -> a2
maximoSegun f = foldl1 (mayorSegun f)

mayorSegun :: Ord a => (p -> a) -> p -> p -> p
mayorSegun f a b
  | f a > f b = a
  | otherwise = b

-- 1. Palos de golf
-- a. Modelar palos

type Palo = Habilidad -> Tiro 

putter :: Palo
putter habilidadJugador = 
    UnTiro {velocidad = 10, precision = ((*2).precisionJugador) habilidadJugador , altura = 0}

madera :: Palo
madera habilidadJugador = 
    UnTiro {velocidad = 100, precision = (precisionJugador habilidadJugador) `div` 2, altura = 5}

hierro :: Int -> Palo
hierro n habilidadJugador = 
    UnTiro {velocidad = ((*n).fuerzaJugador) habilidadJugador, precision = (precisionJugador habilidadJugador) `div` n, altura = max 0 (n - 3)}

-- b. Definir constante palos

palos :: [Palo]
palos = [putter, madera] ++ map hierro [1..10]

-- 2. Funcion golpe

golpe :: Palo -> Jugador -> Tiro 
golpe palo = palo.habilidad

-- Se podria definir como la funcion id, pero seria muy generica

-- 3. Obstaculos

type Obstaculo = Jugador -> Palo -> Tiro

superaTunelConRampita :: Jugador -> Palo -> Bool 
superaTunelConRampita jugador palo =
    ((>90).precision.golpe palo) jugador && ((==0).altura.golpe palo) jugador

superaLaguna :: Jugador -> Palo -> Bool  
superaLaguna jugador palo =
    ((>80).velocidad.golpe palo) jugador && (between 1 5.altura.golpe palo) jugador

superaHoyo :: Jugador -> Palo -> Bool 
superaHoyo jugador palo =
    ((>95).precision.golpe palo) jugador && (between 5 20.velocidad.golpe palo) jugador && ((==0).altura.golpe palo) jugador

efectoTunelConRampita :: Obstaculo    
efectoTunelConRampita jugador palo 
    | superaTunelConRampita jugador palo = UnTiro {velocidad = ((*2).velocidad.golpe palo) jugador, precision = 100, altura = 0}
    | otherwise = tiroDetenido jugador palo

efectoLaguna :: Int -> Obstaculo
efectoLaguna longitudLaguna jugador palo 
    | superaLaguna jugador palo = UnTiro {velocidad = (velocidad.golpe palo) jugador, precision = (precision.golpe palo) jugador, altura = ((altura.golpe palo) jugador) `div` longitudLaguna}
    | otherwise = tiroDetenido jugador palo

efectoHoyo :: Obstaculo
efectoHoyo _ _ = UnTiro {velocidad = 0, precision = 0, altura = 0}

tiroDetenido :: Obstaculo
tiroDetenido = efectoHoyo

-- 4.

--palosUtiles :: Jugador -> Obstaculo -> [Palo]
--palosUtiles jugador obstaculos = filter (sirveParaSuperar jugador obstaculos) palos

-- sirveParaSuperar :: Jugador -> Palo -> Obstaculo -> Bool
sirveParaSuperar jugador obstaculos palo = golpe jugador palo

--obstaculosConsecutivos obstaculos tiro

--paloMasUtil jugador obstaculos

-- 5. padrePerdedor

--padrePerdedor