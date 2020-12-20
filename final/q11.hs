fun lis =
  let f [] acc = acc
      f (x : xs) acc = f xs (acc ++ [y ++ [x] | y <- acc])
   in f lis [[]]