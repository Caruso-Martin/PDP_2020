import Text.Show.Functions()

--- PARTE 1
-- Punto 1

--type Item = 

data Persona = Persona {
    edad        :: Int,
    experiencia :: Int,
    items       :: [String]
    --items :: [Item]
} deriving Show

dipper = Persona {
    edad        = 15,
    experiencia = 30,
    items       = ["soplador de hojas"]     
}

mabel = Persona {
    edad        = 15,
    experiencia = 12,
    items       = ["disfraz de oveja"]     
}

pacifica = Persona {
    edad        = 16,
    experiencia = 8,
    items       = ["dinero"]     
}

----
{-
data Criatura = Criatura {
    ganarPelea :: Poder
    experienciaGanada :: Poder
} deriving Show
-}
--SD E=1 --> no

siempreDetras = False

--GN E=2**C --> soplador
--FA E=20*N  


-- Punto 2

--experienciaGanada persona criatura
--  | criatura persona = 
--  | otherwise = Persona {experiencia = ((+1).experiencia) persona }

-- Punto 3

--experienciaEnCombates = 