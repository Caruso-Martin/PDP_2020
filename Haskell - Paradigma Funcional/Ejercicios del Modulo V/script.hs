-- 5. Ejercicio integrador
import Text.Show.Functions

-- 5.1. Alumnos
data Alumno = Alumno 
    {
        nombre :: String, 
        fechaNacimiento :: (Int, Int, Int), 
        legajo :: Int, 
        materiasQueCursa :: [String],
        criterioEstudio :: CriterioEstudio
    } deriving (Show)

-- 5.2. Requermientos
    -- 3. Modelar un parcial
    -- 4. Modelar el tipo que representa el criterio de estudio.
    -- 5. Modelar genéricamente un alumno.
    -- 6. Representar con la abstracción que crea más conveniente al criterio estudioso, hijo del rigor y cabulero.
    -- 7. Modelar a Nico, un alumno estudioso
    -- 8. Hacer que Nico pase de ser estudioso a hijo del rigor (buscar una abstracción lo suficientemente genérica)
    -- 9. Determinar si Nico va a estudiar para el parcial de Paradigmas

-- 5.3. Modelar un parcial
data Parcial = Parcial {materia :: String, cantidadPreguntas :: Int} deriving (Show, Eq)

-- 5.4. Modelar el tipo que representa el criterio de estudio
type CriterioEstudio = Parcial -> Bool

-- 5.6 Representar los criterios de estudio enunciados
estudioso :: CriterioEstudio
estudioso _ = True

hijoDelRigor :: Int -> CriterioEstudio
hijoDelRigor n (Parcial _ preguntas) = preguntas > n

cabulero :: CriterioEstudio
cabulero (Parcial materia _) = (odd . length) materia

-- 5.7 Modelar a Nico, un alumno estudioso
nico = Alumno {
    fechaNacimiento = (10, 3, 1993),
    nombre = "Nico",
    materiasQueCursa = ["sysop", "proyecto"],
    criterioEstudio = estudioso,
    legajo = 124124
}

-- 5.8 Nico pasa de estudioso a hijo del rigor
cambiarCriterioEstudio :: CriterioEstudio -> Alumno -> Alumno
cambiarCriterioEstudio nuevoCriterio (Alumno nombre fecha legajo materias _) = (Alumno nombre fecha legajo materias nuevoCriterio)

-- 5.9 Saber si un alumno va a estudiar para el parcial de Paradigmas
estudia :: Parcial -> Alumno -> Bool
estudia parcial alumno = (criterioEstudio alumno) parcial