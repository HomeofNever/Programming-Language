fun_a =
  let x = 0
      fun_c f = let x = 1 in f x
      fun_d y = x + y
      fun_b = let x = 3 in (fun_c fun_d)
   in fun_b