estanOrdenados :: [Int] -> Bool
estanOrdenados [] = True
estanOrdenados [x] = odd x
estanOrdenados (x:y:ys) = odd x && even y && estanOrdenados ys