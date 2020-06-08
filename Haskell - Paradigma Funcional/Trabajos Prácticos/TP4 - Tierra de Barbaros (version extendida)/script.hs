-- Trabajo Práctico - Paradigmas de Programacion
-- Hecho por Martín Caruso

import Data.Char
import Text.Show.Functions()

type Objeto = Barbaro -> Barbaro 

data Barbaro = Barabaro {
    nombre      :: String,
    fuerza      :: Int,
    habilidades :: [String],
    objetos     :: [Objeto]
} deriving Show

----Barabaros
dave :: Barbaro
dave = Barabaro {
    nombre      = "Dave",
    fuerza      = 100,
    habilidades = ["tejer","escribirPoesia"],
    objetos     = [ardilla, varitasDefectuosas]
}

thor :: Barbaro
thor = Barabaro {
    nombre      = "Thor",
    fuerza      = 1000,
    habilidades = ["volar","lanzarMartillo"],
    objetos     = [(amuletosMisticos "tirarRayos"), (espadas 50)]
}

loki :: Barbaro
loki = Barabaro {
    nombre      = "Loki",
    fuerza      = 750,
    habilidades = ["Escribir Poesía Atroz","Camuflarse","Lengua afilada"],
    objetos     = [(amuletosMisticos "tirarRayos"), ardilla]
}

faffy :: Barbaro
faffy = Barabaro {
    nombre      = "Faffy",
    fuerza      = 90,
    habilidades = ["CorrerLento","miopia","robar","Escribir Poesía Atroz"],
    objetos     = [(amuletosMisticos "tirarRayos"), (espadas 70)]
}

astro :: Barbaro
astro = Barabaro {
    nombre      = "Astro",
    fuerza      = 90,
    habilidades = ["robar"],
    objetos     = [varitasDefectuosas, (espadas 10)]
}

----1.OBJETOS
----Espadas

espadas :: Int -> Objeto
espadas peso barbaro = 
    barbaro {fuerza = fuerza barbaro + 2 * peso, objetos = objetos barbaro ++ [espadas peso]}

--espadas 50 dave -> Barabaro {nombre = "Dave", fuerza = 200, habilidades = ["tejer","escribirPoesia"], objetos = [<function>,<function>,<function>]}
--espadas 40 thor -> Barabaro {nombre = "Thor", fuerza = 1080, habilidades = ["volar","lanzarMartillo"], objetos = [<function>,<function>,<function>]}

----Amuletos misticos

amuletosMisticos :: [Char] -> Objeto
amuletosMisticos habilidadNueva barbaro = 
    barbaro {habilidades = habilidades barbaro ++ [habilidadNueva], objetos = objetos barbaro ++ [amuletosMisticos habilidadNueva]}

--amuletosMisticos "rayosLaser" thor        -> Barabaro {nombre = "Thor", fuerza = 1000, habilidades = ["volar","lanzarMartillo","rayosLaser"], objetos = [<function>,<function>,<function>]}
--amuletosMisticos "superVelocidad" dave    -> Barabaro {nombre = "Dave", fuerza = 100, habilidades = ["tejer","escribirPoesia","superVelocidad"], objetos = [<function>,<function>,<function>]}

----Varitas defectuosas

varitasDefectuosas :: Objeto
varitasDefectuosas barbaro = 
    barbaro {habilidades = habilidades barbaro ++ ["hacerMagia"], objetos = [varitasDefectuosas]}

--varitasDefectuosas thor -> Barabaro {nombre = "Thor", fuerza = 1000, habilidades = ["volar","lanzarMartillo","hacerMagia"], objetos = [<function>]}

----Ardilla

ardilla :: Objeto
ardilla barbaro = 
    barbaro {objetos = objetos barbaro ++ [ardilla]}

--ardilla dave -> Barabaro {nombre = "Dave", fuerza = 100, habilidades = ["tejer","escribirPoesia"], objetos = [<function>,<function>,<function>]}

----Cuerda

cuerda :: Objeto -> Objeto -> Objeto
cuerda objeto1 objeto2 barbaro = 
    (objeto2.objeto1) barbaro

--cuerda (espadas 30) ardilla dave                              -> Barabaro {nombre = "Dave", fuerza = 160, habilidades = ["tejer","escribirPoesia"], objetos = [<function>,<function>,<function>,<function>]}
--cuerda varitasDefectuosas (amuletosMisticos "cantar") thor    -> Barabaro {nombre = "Thor", fuerza = 1000, habilidades = ["volar","lanzarMartillo","hacerMagia","cantar"], objetos = [<function>,<function>]}
--cuerda (amuletosMisticos "cantar") varitasDefectuosas thor    -> Barabaro {nombre = "Thor", fuerza = 1000, habilidades = ["volar","lanzarMartillo","cantar","hacerMagia"], objetos = [<function>]}

-------

----2.MEGAFONO BARBARICO

toUpperString :: String -> [Char]
toUpperString = map toUpper

--megafono :: Objeto
--megafono barbaro =
--    barbaro {habilidades = foldl (++) [] $ map toUpperString (habilidades barbaro)}

-------3.AVENTURA

type Evento = Barbaro -> Bool
type Prueba = Barbaro -> Bool

---- Invasion de sucios duendes

invasionDeSuciosDuendes :: Evento
invasionDeSuciosDuendes barbaro = any (=="Escribir Poesía Atroz") (habilidades barbaro)

---- Cremallera del tiempo

cremalleraDelTiempo :: Evento
cremalleraDelTiempo barbaro = 
    elem (nombre barbaro) ["Faffy","Astro"]

----Ritual de fechorias

saqueo :: Prueba
saqueo barbaro = 
    any (=="robar") (habilidades barbaro) && fuerza barbaro > 80

---

poderGrito :: Barbaro -> Int
poderGrito = ((*4).length.objetos)

cantidadDeLetrasHabilidades :: Barbaro -> Int
cantidadDeLetrasHabilidades = sum.(map length).habilidades 

gritoDeGuerra :: Prueba
gritoDeGuerra barbaro = 
    poderGrito barbaro >= cantidadDeLetrasHabilidades barbaro

---

esVocal :: Char -> Bool
esVocal letra = elem letra ['a','e','i','o','u','A','E','I','O','U']

masDeTresVocales :: String -> Bool
masDeTresVocales cadena = (length $ filter esVocal cadena) > 3

caligrafia :: Prueba
caligrafia barbaro = (all masDeTresVocales (habilidades barbaro)) && (all (isUpper.head) (habilidades barbaro))  

---

ritualDeFechorias :: Evento
ritualDeFechorias barbaro = 
    saqueo barbaro || gritoDeGuerra barbaro || caligrafia barbaro

-----Eventos

aventuraFacil :: [Barbaro] -> Evento -> [Bool]
aventuraFacil barbaros evento = map evento barbaros

aventuraDificil :: [Barbaro] -> Evento -> Evento -> [Bool]
aventuraDificil barbaros evento1 evento2 = 
    zipWith (&&) (aventuraFacil barbaros evento1) (aventuraFacil barbaros evento2)

aventuraMuyDificil :: [Barbaro] -> Evento -> Evento -> Evento -> [Bool]
aventuraMuyDificil barbaros evento1 evento2 evento3 = 
    zipWith (&&) (aventuraDificil barbaros evento1 evento2) (aventuraFacil barbaros evento3)


---- Sobrevivientes

--sobrevivientes barbaros aventura = filter aventura barbaros


------4.DINASTIA
----Sin repetidos



----Descendientes

-----Pregunta: ¿Se podría aplicar sinRepetidos sobre la lista de objetos? ¿Y sobre el nombre de un bárbaro? ¿Por qué?
----Respuesta: 