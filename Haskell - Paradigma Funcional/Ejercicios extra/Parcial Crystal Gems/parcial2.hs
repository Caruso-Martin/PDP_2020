import Text.Show.Functions()

data Aspecto = UnAspecto {
  tipoDeAspecto :: String,
  grado :: Float
} deriving (Show, Eq)

type Situacion = [Aspecto]

-- Aspectos

tension = UnAspecto {
  tipoDeAspecto = "Tension",
  grado         = 15
}

incertidumbre = UnAspecto {
  tipoDeAspecto = "Incertidumbre",
  grado         = 25
}

peligro = UnAspecto {
  tipoDeAspecto = "Peligro",
  grado         = 35
}

tensionB = UnAspecto {
  tipoDeAspecto = "Tension",
  grado         = 20
}

incertidumbreB = UnAspecto {
  tipoDeAspecto = "Incertidumbre",
  grado         = 30
}

peligroB = UnAspecto {
  tipoDeAspecto = "Peligro",
  grado         = 40
}

tensionC = UnAspecto {
  tipoDeAspecto = "Tension",
  grado         = 30
}

incertidumbreC = UnAspecto {
  tipoDeAspecto = "Incertidumbre",
  grado         = 50
}

peligroC = UnAspecto {
  tipoDeAspecto = "Peligro",
  grado         = 70
}
-- Situaciones

situacionA = [tension, incertidumbre, peligro]   
situacionB = [tensionB, peligroB]   
situacionC = [tensionC, incertidumbreC]   
situacionD = [peligro]   

-- Definiciones basicas y utiles

mejorAspecto :: Aspecto -> Aspecto -> Bool
mejorAspecto mejor peor = grado mejor < grado peor

mismoAspecto :: Aspecto -> Aspecto -> Bool
mismoAspecto aspecto1 aspecto2 = tipoDeAspecto aspecto1 == tipoDeAspecto aspecto2

buscarAspecto :: Aspecto -> [Aspecto] -> Aspecto
buscarAspecto aspectoBuscado = head.filter (mismoAspecto aspectoBuscado)

buscarAspectoDeTipo :: String -> [Aspecto] -> Aspecto 
buscarAspectoDeTipo tipo = buscarAspecto (UnAspecto tipo 0)

reemplazarAspecto :: Aspecto -> [Aspecto] -> [Aspecto]
reemplazarAspecto aspectoBuscado situacion =
    aspectoBuscado : (filter (not.mismoAspecto aspectoBuscado) situacion)

-- 1. Trabajando con Situaciones

modificarAspecto :: (Float -> Float) -> Aspecto -> Aspecto
modificarAspecto modificador aspecto = aspecto {grado = (modificador . grado) aspecto}

mejorSituacion :: [Aspecto] -> [Aspecto] -> Bool
mejorSituacion  [] _ = True
mejorSituacion (x : xs) situacion2 = mejorAspecto x aspectoCorrespondiente && mejorSituacion xs situacion2
    where aspectoCorrespondiente = (buscarAspectoDeTipo (tipoDeAspecto x) situacion2)

modificarSituacion :: String -> Float -> [Aspecto] -> [Aspecto]
modificarSituacion tipoAspecto nuevoGrado =
    reemplazarAspecto (UnAspecto tipoAspecto nuevoGrado) 

-- 2. Modelando Gemas y personalidades posibles

data Gema = UnaGema {
    nombre          :: String,
    fuerza          :: Int,
    personalidad    :: [Personalidad]
} deriving Show

tipoModificacion tipo modificacion aspecto
    | mismoAspecto (UnAspecto tipo 0) aspecto = aspecto {grado = (modificacion . grado) aspecto} 
    | otherwise = aspecto

type Personalidad = [Aspecto] -> [Aspecto]

vidente :: Personalidad
vidente = map (\x -> (tipoModificacion "Tension" (+(-10)) . tipoModificacion "Incertidumbre" (*0.5)) x) 
  
relajada :: Float -> Personalidad
relajada relajacion = map (\x -> (tipoModificacion "Tension" (+(-30)) . tipoModificacion "Peligro" (+relajacion)) x) 

gemaRelax = UnaGema {
    nombre          = "Relajada",
    fuerza          = 12,
    personalidad    = [relajada 12]
}

gemaVidente = UnaGema {
    nombre          = "Vidente",
    fuerza          = 19,
    personalidad    = [vidente]
}

-- Punto 3

mejorGema :: [Aspecto] -> Gema -> Gema -> Bool
mejorGema situacion gema1 gema2 = esMasFuerte && mejorDesempenio
    where 
        esMasFuerte = fuerza gema1 > fuerza gema2
        desempenio gema = foldr ($) situacion (personalidad gema)
        mejorDesempenio = mejorSituacion (desempenio gema1) (desempenio gema2)

-- Punto 4

cambioNombre :: Gema -> Gema -> String
cambioNombre gema1 gema2
    | nombre gema1 == nombre gema2 = nombre gema1
    | otherwise = (nombre gema1) ++ (nombre gema2)

enTodoMenos10 :: Personalidad
enTodoMenos10 = map (\x -> (tipoModificacion "Peligro" (+(-10)) . tipoModificacion "Tension" (+(-10)) . tipoModificacion "Incertidumbre" (+(-10))) x) 

{-
fuerzaFusionada situacion gema1 gema2 
    | mejorSituacion = 1
    | mejorGema gema1 gema2 = ((*7) . fuerza) gema1  
    | otherwise = ((*7) . fuerza) gema2
-}

-- Punto 5 

--fusionGrupal (x : y : ys) situacion = foldl (fusion situacion) x ys