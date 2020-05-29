-- Trabajo Práctico - Paradigmas de Programacion
-- Hecho por Martín Caruso

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

----OBJETOS
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