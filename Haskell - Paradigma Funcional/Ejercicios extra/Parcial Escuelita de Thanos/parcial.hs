import Text.Show.Functions()

-- Universos, Personajes y Guanteletes

guantelete1 = Guantelete {
  material      = "uru",
  gemas         = [mente 5, alma "volar", espacio "Neptuno", poder, tiempo, gemaLoca (mente 5)] 
}

guantelete2 = Guantelete {
  material      = "uru",
  gemas         = [mente 5, alma "magia", tiempo] 
}

---

ironMan = Personaje {
  nombre        = "Tony Stark",
  edad          = 47,          
  energia       = 70,
  dondeVive     = "Tierra",
  habilidades   = ["volar", "dipararRayos", "ingenieria"]
} 

groot = Personaje {
  nombre        = "Groot",
  edad          = 15,          
  energia       = 60,
  dondeVive     = "Groot",
  habilidades   = ["groot"]
} 

thor = Personaje {
  nombre        = "Thor Odinnson",
  edad          = 3234,          
  energia       = 100,
  dondeVive     = "Asgard",
  habilidades   = ["volar", "usar Mjolnir"]
} 

drStrange = Personaje {
  nombre        = "Dr. Steven Strange",
  edad          = 45,          
  energia       = 80,
  dondeVive     = "Tierra",
  habilidades   = ["volar", "magia"]
} 

viudaNegra = Personaje {
  nombre        = "Natasha Romanov",
  edad          = 33,          
  energia       = 30,
  dondeVive     = "Tierra",
  habilidades   = ["espia", "agilidad"]
} 

---

universoA = Universo {
    personajes = [thor, ironMan, groot, drStrange]
}

universoB = Universo {
    personajes = [thor, ironMan, drStrange]
}

-- Parte 1
-- Punto 1

data Guantelete  = Guantelete {
  material      :: String,
  gemas         :: [Gema]
} deriving Show

data Personaje = Personaje {
  nombre        :: String,
  edad          :: Int,
  energia       :: Int,
  dondeVive     :: String,
  habilidades   :: [String]
} deriving (Eq, Show)

data Universo = Universo {
  personajes    :: [Personaje]
} deriving (Eq, Show)

chasquidoUniversal :: Guantelete -> Universo -> Universo
chasquidoUniversal guantelete universo
    | ((==6) . length . gemas) guantelete = universo {personajes = (take mitadPersonajes . personajes) universo  } 
    | otherwise = universo 
    where mitadPersonajes = (length . personajes) universo `div` 2

-- Punto 2

aptoParaJovenes :: Universo -> Bool
aptoParaJovenes universo = any ((<45) . edad) (personajes universo)

energiaUniversal :: Universo -> Int
energiaUniversal = sum . map energia . personajes 

-- Parte 2
-- Punto 3

type Gema = Personaje -> Personaje

mente :: Int -> Gema
mente valor personaje = personaje {energia = energia personaje - valor}

alma :: String -> Gema
alma habilidad personaje = (mente 10) personaje {habilidades = filter (not . (==habilidad)) (habilidades personaje)}

espacio :: String -> Gema
espacio planeta personaje = (mente 20) personaje {dondeVive = planeta}

poder :: Gema
poder personaje = personaje {energia = 0, habilidades = drop habilidadEliminadas (habilidades personaje)}
    where 
    cantidadHabiliadades = (length . habilidades) personaje
    habilidadEliminadas 
        | cantidadHabiliadades <= 2 = cantidadHabiliadades
        | otherwise = 0

tiempo :: Gema
tiempo personaje = (mente 50) personaje {edad = max 18 (edad personaje `div` 2)}
  
gemaLoca :: Gema -> Gema
gemaLoca gema = gema . gema 

-- Punto 4

guanteleteDeGoma = Guantelete {
  material      = "goma",
  gemas         = [tiempo, alma "usar Mjolnir", gemaLoca (alma "programacion en Haskell")] 
}

-- Punto 5

listaGemas1 = [mente 10, alma "magia", espacio "Tierra", poder, tiempo, gemaLoca (mente 10)] 

utilizar listaGemas enemigo = foldl (\e g -> g e) enemigo listaGemas


-- Punto 6

gemaMasPoderosa personaje [] = []
gemaMasPoderosa personaje guantelete = filter maxDanio (gemas guantelete)
    where maxDanio = 

-- Punto 7 
{-
A. No sera posible ejecutar `gemaMasPoderosa punisher guanteleteDeLocos`.

Esto se debe a que cuando aplicamos una funcion que requiere de todos los valores de una lista,
sera imprescindible conocer todos los valores de la misma. 

En este caso en particular, al ser infinita la lista, no se terminara de aplicar la funcion a cada elemento resultando entonces, en una divergencia.

B. Si sera posible ejecutar `usoLasTresPrimerasGemas guanteleteDeLocos punisher`.

Esto es posible gracias a un concepto llamado "evaluacion diferida", el cual aplica a Haskell.
Aunque el `guanteleteDeLocos` no pare de generar gemas en posesion (a causa de la funcion `infinitasGemas`), 
la funcion `usoLasTresPrimerasGemas` acota la lista infinita (gracias al `take 3`) y Haskell hace uso de solo las primeras 3 gemas del guantelete. 

-}