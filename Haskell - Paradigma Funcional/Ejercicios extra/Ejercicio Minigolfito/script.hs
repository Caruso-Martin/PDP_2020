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

golpe' :: Jugador -> Palo -> Tiro 
golpe' jugador palo = (palo.habilidad) jugador

-- 3. Obstaculos

type Obstaculo = Tiro -> Bool

tunelConRampita :: Obstaculo
tunelConRampita tiro = 
    ((>90).precision) tiro && ((==0).altura) tiro 

laguna :: Obstaculo
laguna tiro = 
    ((>80).velocidad) tiro && (between 1 5.altura) tiro

hoyo :: Obstaculo
hoyo tiro = 
    ((>90).precision) tiro && (between 5 20.velocidad) tiro && ((==0).altura) tiro 

--- Como queda un tiro 

tiroDetenido :: Tiro
tiroDetenido = UnTiro {velocidad = 0, precision = 0, altura = 0}

tiroPostTunel :: Tiro -> Tiro
tiroPostTunel tiro 
    | tunelConRampita tiro = UnTiro {velocidad = ((*2).velocidad) tiro, precision = 100, altura = 0}
    | otherwise = tiroDetenido

tiroPostLaguna :: Int -> Tiro -> Tiro
tiroPostLaguna longitudLaguna tiro
    | laguna tiro = UnTiro {velocidad = velocidad tiro, precision = precision tiro, altura = (altura tiro) `div` longitudLaguna}
    | otherwise = tiroDetenido

tiroPostHoyo :: Tiro -> Tiro
tiroPostHoyo _ = tiroDetenido

-- 4. Palos de utilidad

supera :: Obstaculo -> Jugador -> Palo -> Bool
supera obstaculo jugador palo = 
    obstaculo (golpe' jugador palo)

palosUtiles :: Jugador -> Obstaculo -> [Palo]
palosUtiles jugador obstaculo = 
    filter (supera obstaculo jugador) palos

--- superaConsecutivos
obstaculosA :: [Obstaculo]
obstaculosA = [laguna, laguna, tunelConRampita, hoyo]

obstaculosB :: [Obstaculo]
obstaculosB = [tunelConRampita, tunelConRampita, hoyo, tunelConRampita, laguna, tunelConRampita, laguna, hoyo]

superaUno :: Tiro -> Obstaculo -> Bool
superaUno tiro obstaculo = obstaculo tiro

superaConsecutivos :: [Obstaculo] -> Tiro -> Int
superaConsecutivos obstaculos tiro = 
    length (takeWhile (superaUno tiro) obstaculos)

--- paloMasUtil

paloMasUtil :: Jugador -> [Obstaculo] -> Palo
paloMasUtil jugador obstaculos = 
    filter (maximoDeTiros == tirosDelPalo) palos
    where 
        maximoDeTiros = maximum (map (superaConsecutivos obstaculos) (map (golpe' jugador) palos)) 
        tirosDelPalo  =  ((superaConsecutivos obstaculos).(golpe' jugador))

-- 5.

rankingTorneo :: [(Jugador, Puntos)]
rankingTorneo = [(bart, 30), (todd, 29), (rafa, 1)]

--puntosCampeon :: [(Jugador, Puntos)] -> Int
--puntosCampeon ranking = maximum (map snd ranking)

padresPerdedores :: [(Jugador, Puntos)] -> [String]
padresPerdedores ranking = 
    map padre jugadoresPerdedores
    where 
        puntosDelCampeon = maximum (map snd ranking)
        jugadoresPerdedores = (map fst (filter ((<puntosDelCampeon).snd) ranking))
     