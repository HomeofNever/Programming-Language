test x = case x of 
    0 -> show 0 
    _ -> test (x - 1)