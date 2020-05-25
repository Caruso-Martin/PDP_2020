-- Trabajo Práctico 3: Monopoly - Paradigmas de Programacion
-- Hecho por Martín Caruso

type Accion = Persona -> Persona

data Propiedad = UnaPropiedad {
  nombrePropiedad :: String,
  precioPropiedad :: Int
} deriving (Show, Eq)


data Persona = UnaPersona {   
    nombre :: String,
    dinero :: Int,
    tactica :: String,
    propiedades :: [Propiedad],
    acciones :: [Accion]    
} deriving Show

manuel :: Persona 
manuel = UnaPersona 
    {  
        nombre      = "Manuel", 
        dinero      = 500, 
        tactica     = "Oferente singular", 
        propiedades = [], 
        acciones    = [pasarPorElBanco, enojarse]
    }

carolina :: Persona
carolina = UnaPersona 
    {  
        nombre      = "Carolina", 
        dinero      = 500, 
        tactica     = "Accionista", 
        propiedades = [], 
        acciones    = [pasarPorElBanco, pagarAAccionistas]
    }
    

-- Auxiliares --
cambiarNombre :: (String -> String) -> Persona -> Persona
cambiarNombre fn persona = persona { nombre = fn.nombre $ persona }

cambiarDinero :: (Int -> Int) -> Persona -> Persona
cambiarDinero fn persona = persona { dinero = fn.dinero $ persona }

cambiarTactica :: (String -> String) -> Persona -> Persona
cambiarTactica fn persona = persona { tactica = fn.tactica $ persona }

agregarAccion :: Accion -> Persona -> Persona
agregarAccion accion persona = persona { acciones = (accion :).acciones $ persona }

agregarPropiedad :: Propiedad -> Persona -> Persona
agregarPropiedad propiedad persona = persona { propiedades = (propiedad :).propiedades $ persona }

quitarPropiedad :: Propiedad -> Persona -> Persona
quitarPropiedad propiedad persona = persona {
  propiedades = filter ((/=) (nombrePropiedad propiedad) . nombrePropiedad) . propiedades $ persona
}
----

pasarPorElBanco :: Accion
pasarPorElBanco persona = cambiarTactica (const "Comprador compulsivo") . cambiarDinero (+40) $ persona

enojarse :: Accion
enojarse persona = cambiarDinero (+50) . agregarAccion gritar $ persona

gritar :: Accion
gritar persona = cambiarNombre ("AHHHH" ++) persona

----

esTacticaGanadora :: String -> Bool
esTacticaGanadora "Oferente singular" = True
esTacticaGanadora "Accionista"        = True
esTacticaGanadora _                   = False

adquirirPropiedad :: Propiedad -> Persona -> Persona
adquirirPropiedad propiedad persona = cambiarDinero (subtract . precioPropiedad $ propiedad) . agregarPropiedad propiedad $ persona

subastar :: Propiedad -> Accion
subastar propiedad persona
  | esTacticaGanadora . tactica $ persona = adquirirPropiedad propiedad persona
  | otherwise                             = persona

----

esPropiedadBarata :: Propiedad -> Bool
esPropiedadBarata propiedad = precioPropiedad propiedad < 150

precioAlquiler :: Propiedad -> Int
precioAlquiler propiedad
  | esPropiedadBarata propiedad = 10
  | otherwise                   = 20

ingresosPorAlquileres :: Persona -> Int
ingresosPorAlquileres persona = sum . map precioAlquiler . propiedades $ persona

cobrarAlquileres :: Accion
cobrarAlquileres persona = cambiarDinero ((+).ingresosPorAlquileres $ persona) persona

----

esAccionista :: Persona -> Bool
esAccionista (UnaPersona _ _ "Accionista" _ _) = True
esAccionista _                                 = False

pagarAAccionistas :: Accion
pagarAAccionistas persona
  | esAccionista persona = cambiarDinero (+200) persona
  | otherwise            = cambiarDinero (subtract 100) persona