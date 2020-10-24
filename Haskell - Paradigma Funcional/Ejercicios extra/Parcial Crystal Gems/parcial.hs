import Text.Show.Functions()

data Aspecto = UnAspecto {
  tipoDeAspecto :: String,
  grado         :: Float
} deriving (Show, Eq)

type Situacion = [Aspecto]

mejorAspecto :: Aspecto -> Aspecto -> Bool
mejorAspecto mejor peor = grado mejor < grado peor

mismoAspecto :: Aspecto -> Aspecto -> Bool
mismoAspecto aspecto1 aspecto2 = tipoDeAspecto aspecto1 == tipoDeAspecto aspecto2

buscarAspecto :: Aspecto -> Situacion -> Aspecto
buscarAspecto aspectoBuscado = head . filter (mismoAspecto aspectoBuscado)

buscarAspectoDeTipo :: String -> Situacion -> Aspecto
buscarAspectoDeTipo tipo = buscarAspecto (UnAspecto tipo 0)

reemplazarAspecto :: Aspecto -> Situacion -> Situacion
reemplazarAspecto aspectoBuscado situacion =
    aspectoBuscado : (filter (not . mismoAspecto aspectoBuscado) situacion)

-- Tipos de situaciones
tensionA = UnAspecto {
  tipoDeAspecto = "Tension",
  grado         = 15
}

incertidumbreA = UnAspecto {
  tipoDeAspecto = "Incertidumbre",
  grado         = 25
}

peligroA = UnAspecto {
  tipoDeAspecto = "Peligro",
  grado         = 40
}

tensionB = UnAspecto {
  tipoDeAspecto = "Tension",
  grado         = 35
}

incertidumbreB = UnAspecto {
  tipoDeAspecto = "Incertidumbre",
  grado         = 20
}

peligroB = UnAspecto {
  tipoDeAspecto = "Peligro",
  grado         = 15
}

situacionA = [tensionA, incertidumbreA, peligroA] -- 15/25/40
situacionB = [tensionB, incertidumbreB, peligroB] -- 35/20/15
situacionC = [tensionA, incertidumbreB, peligroA] -- 15/20/40

---

-- Punto 1 - Trabajando con 'Situaciones'

-- A
modificarAspecto :: (Float -> Float) -> Aspecto -> Aspecto
modificarAspecto modificador aspecto = 
    aspecto {grado = (modificador . grado) aspecto}

-- B
--mejorSituacion situacion1 situacion2 = 
    
-- C
--modificarSituacion :: String -> Float -> Situacion -> Situacion
--modificarSituacion tipoAspecto modificador situacion =
--    reemplazarAspecto (UnAspecto {tipoDeAspecto = tipoAspecto, grado = (modificador . grado) situacion}) 

---

-- Punto 2 - Modelando 'Gemas' y personalidades posibles

-- A
data Gema = UnaGema {
  nombre :: String,
  fuerza :: Int,
  personalidad :: [String]
} deriving (Show, Eq)

-- B
--vidente situacion = modificarSituacion "Incertidumbre"  (((*0.5) . grado . buscarAspectoDeTipo "Incertidumbre") situacion) situacion

--relajada


