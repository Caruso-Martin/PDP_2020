-- Trabajo Práctico 1: Hora de Lectura - Paradigmas de Programacion
-- Hecho por Martín Caruso
data Libro = Libro {nombre :: String, autor :: String, saga :: String, paginas :: Int, capitulo :: Int} deriving (Show, Eq)

-- Biblioteca
elVisitante =           Libro {nombre = "El visitante",         autor = "Stephen King",         saga = "El visitante",          paginas = 592,  capitulo = 1}
shingekiNoKyojin1 =     Libro {nombre = "Shingeki no Kyojin",   autor = "Hajime Isayama",       saga = "Shingeki no Kyojin",    paginas = 40,   capitulo = 1}
shingekiNoKyojin3 =     Libro {nombre = "Shingeki no Kyojin",   autor = "Hajime Isayama",       saga = "Shingeki no Kyojin",    paginas = 40,   capitulo = 3}
shingekiNoKyojin127 =   Libro {nombre = "Shingeki no Kyojin",   autor = "Hajime Isayama",       saga = "Shingeki no Kyojin",    paginas = 40,   capitulo = 127}
fundacion =             Libro {nombre = "Fundacion",            autor = "Isaac Asimov",         saga = "Fundacion",             paginas = 230,  capitulo = 1}
sandman5 =              Libro {nombre = "Sandman",              autor = "Neil Gaiman",          saga = "Sandman",               paginas = 35,   capitulo = 5}
sandman10 =             Libro {nombre = "Sandman",              autor = "Neil Gaiman",          saga = "Sandman",               paginas = 35,   capitulo = 10}
sandman12 =             Libro {nombre = "Sandman",              autor = "Neil Gaiman",          saga = "Sandman",               paginas = 35,   capitulo = 12}
eragonEragon =          Libro {nombre = "Eragon",               autor = "Christopher Paolini",  saga = "Eragon",                paginas = 544,  capitulo = 1}
eragonEldest =          Libro {nombre = "Eldest",               autor = "Christopher Paolini",  saga = "Eragon",                paginas = 704,  capitulo = 1}
eragonBrisignr =        Libro {nombre = "Brisignr",             autor = "Christopher Paolini",  saga = "Eragon",                paginas = 700,  capitulo = 1} 
eragonLegado =          Libro {nombre = "Legado",               autor = "Christopher Paolini",  saga = "Eragon",                paginas = 811,  capitulo = 1}

-- Funciones
lecturaObligatoria :: Libro -> Bool
lecturaObligatoria libro = (("Stephen King"==).autor) libro || (("Eragon"==).saga) libro || (("Fundacion"==).nombre) libro

-- lecturaObligatoria eragonLegado  -> True
-- lecturaObligatoria fundacion     -> True
-- lecturaObligatoria elVisitante   -> True
-- lecturaObligatoria sandman5      -> False

esFantasioso :: Libro -> Bool
esFantasioso libro = (("Christopher Paolini"==).autor) libro || (("Neil Gaiman"==).autor) libro

-- esFantasioso eragonBrisignr      -> True
-- esFantasioso sandman10           -> True
-- esFantasioso shingekiNoKyojin127 -> False

esLigero :: Libro -> Bool
esLigero = (<41).paginas

-- esLigero sandman12           -> True
-- esLigero shingekiNoKyojin1   -> True
-- esLigero eragonBrisignr      -> False