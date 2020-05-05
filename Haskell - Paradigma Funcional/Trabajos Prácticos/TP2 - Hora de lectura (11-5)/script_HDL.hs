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

--Obtener 3 a 5 en tupla
trd :: (a, b, c, d, e) -> c
trd (_, _, c, _, _) = c

forth :: (a, b, c, d, e) -> d
forth (_, _, _, d, _) = d

fifth :: (a, b, c, d, e) -> e
fifth (_, _, _, _, e) = e

-- Funciones
lecturaObligatoria :: Libro -> Bool
lecturaObligatoria = (== "Stephen King").autor.snd || (== "Eragon").saga.trd || (== "Fundacion").nombre.fst

esFantasioso :: Libro -> Bool
esFantasioso = (== "Christopher Paolini").autor.snd || (== "Neil Gaiman").autor.snd  

esLigero :: Libro -> Bool
esLigero = (<41).paginas