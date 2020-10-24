import Text.Show.Functions()

data Pais = Pais {
    ingresoPerCapita                :: Float,
    poblacionActivaSectorPublico    :: Int,
    poblacionActivaSectorPrivado    :: Int,
    deuda                           :: Float,
    recursosNaturales               :: [String] 
} deriving (Eq, Show)


-- Punto 1

namibia = Pais {
    ingresoPerCapita                = 4140,
    poblacionActivaSectorPublico    = 400000,
    poblacionActivaSectorPrivado    = 650000,
    deuda                           = 50,
    recursosNaturales               = ["mineria", "ecoturismo"]
}

-- Punto 2
type Estrategia = Pais -> Pais 

prestar :: Float -> Estrategia
prestar millones pais = 
    pais {deuda = ((1.5 * millones+) . deuda) pais }

recortesLaboralesPublicos :: Int -> Estrategia
recortesLaboralesPublicos cantidad pais = 
    pais {poblacionActivaSectorPublico = poblacionActivaSectorPublico pais - cantidad, ingresoPerCapita = ((* porcenatajeReduccion).ingresoPerCapita) pais }
        where 
        porcenatajeReduccion 
            | cantidad > 100 = 0.80
            | otherwise = 0.85

venderseAlFMI :: String -> Estrategia
venderseAlFMI recurso pais = 
    pais {deuda = deuda pais - 2, recursosNaturales = filter (not.(==recurso)) (recursosNaturales pais)}

blindaje :: Estrategia
blindaje pais = (prestar ((pbi pais)/2) . recortesLaboralesPublicos 500) pais

pbi pais = ingresoPerCapita pais * fromIntegral (poblacionActiva)
    where poblacionActiva = poblacionActivaSectorPrivado pais + poblacionActivaSectorPublico pais

-- Punto 3

receta = [prestar 200, venderseAlFMI "mineria"]

-- Punto 4

argentina = Pais {
    ingresoPerCapita                = 12000,
    poblacionActivaSectorPublico    = 150000,
    poblacionActivaSectorPrivado    = 5600000,
    deuda                           = 100,
    recursosNaturales               = ["agricultura", "ganaderia"]
}

venezuela = Pais {
    ingresoPerCapita                = 3222,
    poblacionActivaSectorPublico    = 1000000,
    poblacionActivaSectorPrivado    = 450000,
    deuda                           = 60,
    recursosNaturales               = ["petroleo"]
}

chile = Pais {
    ingresoPerCapita                = 17000,
    poblacionActivaSectorPublico    = 50000,
    poblacionActivaSectorPrivado    = 3000000,
    deuda                           = 50,
    recursosNaturales               = ["cobre", "plata"]
}

zafan :: [Pais] -> [Pais]
zafan paises = 
    filter (\p -> any (=="petroleo") (recursosNaturales p)) paises

deudaAFavor :: [Pais] -> Float
deudaAFavor = sum.map deuda 

-- Punto 5
type Receta = [Estrategia]

recetaA = [prestar 100, venderseAlFMI "petroleo", blindaje]
recetaB = [prestar 20, recortesLaboralesPublicos 300, venderseAlFMI "cobre"]
recetaC = [prestar 50, blindaje]
recetaD = [prestar 90, recortesLaboralesPublicos 50, venderseAlFMI "agricultura", blindaje]


{-recetasOrdenadas pais [] = True
recetasOrdenadas pais (r : rs) = pbiResultante r < pbiResultante rs 
    where pbiResultante receta = pbi (foldl (\x y -> y x) pais receta) -}
     
