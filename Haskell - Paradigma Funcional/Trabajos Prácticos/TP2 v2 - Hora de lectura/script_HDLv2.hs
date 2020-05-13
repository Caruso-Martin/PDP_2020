-- Trabajo Práctico 2 v2: Hora de Lectura - Paradigmas de Programacion
-- Hecho por Martín Caruso
data Libro = Libro {nombre :: String, autor :: String, paginas :: Int} deriving (Show, Eq)
type Biblioteca = [Libro]

-- Biblioteca
elVisitante =         Libro {nombre = "El visitante",                      autor = "Stephen King",        paginas = 592 }
shingekiNoKyojin1 =   Libro {nombre = "Shingeki no Kyojin - Capitulo 1",   autor = "Hajime Isayama",      paginas = 40  }
shingekiNoKyojin3 =   Libro {nombre = "Shingeki no Kyojin - Capitulo 3",   autor = "Hajime Isayama",      paginas = 40  }
shingekiNoKyojin127 = Libro {nombre = "Shingeki no Kyojin - Capitulo 127", autor = "Hajime Isayama",      paginas = 40  }
fundacion =           Libro {nombre = "Fundacion",                         autor = "Isaac Asimov",        paginas = 230 }
sandman5 =            Libro {nombre = "Sandman - Capitulo 5",              autor = "Neil Gaiman",         paginas = 35  }
sandman10 =           Libro {nombre = "Sandman - Capitulo 10",             autor = "Neil Gaiman",         paginas = 35  }
sandman12 =           Libro {nombre = "Sandman - Capitulo 12",             autor = "Neil Gaiman",         paginas = 35  }
eragon =              Libro {nombre = "Eragon",                            autor = "Christopher Paolini", paginas = 544 }
eldest =              Libro {nombre = "Eldest",                            autor = "Christopher Paolini", paginas = 704 }
brisignr =            Libro {nombre = "Brisignr",                          autor = "Christopher Paolini", paginas = 700 } 
legado =              Libro {nombre = "Legado",                            autor = "Christopher Paolini", paginas = 811 }

biblioteca = [elVisitante, shingekiNoKyojin1, shingekiNoKyojin3, shingekiNoKyojin127, fundacion, sandman5, sandman10, sandman12, eragon, eldest, brisignr, legado] 

-- Promedio de hojas
totalDeHojas :: Biblioteca -> Int
totalDeHojas = sum . map paginas

promedioDeHojas :: Biblioteca -> Float
promedioDeHojas biblioteca = fromIntegral (totalDeHojas biblioteca) / fromIntegral (length biblioteca)

-- Biblioteca fantasiosa
esFantasioso :: Libro -> Bool
esFantasioso libro = elem (autor libro) ["Christopher Paolini", "Neil Gaiman"]

bibliotecaFantasiosa :: Biblioteca -> Bool
bibliotecaFantasiosa biblioteca = any esFantasioso biblioteca  

-- Nombre de biblioteca
esVocal :: Char -> Bool
esVocal letra = elem letra ['A', 'a', 'E', 'e', 'I', 'i', 'O', 'o', 'U', 'u']

nombreDeLaBiblioteca :: Biblioteca -> String
nombreDeLaBiblioteca biblioteca = (filter (not . esVocal) . concat . map nombre) biblioteca

-- Es biblioteca ligera
esLigero :: Libro -> Bool
esLigero = (<=40) . paginas 

bibliotecaLigera :: Biblioteca -> Bool
bibliotecaLigera biblioteca = all esLigero biblioteca  