shouldBeUnique :: Eq a => [a] -> [a] -> [a]
shouldBeUnique lis res
  | null lis = res
  | null res = shouldBeUnique (tail lis) [head lis]
  | head lis == head res = shouldBeUnique (tail lis) res
  | otherwise = shouldBeUnique (tail lis) (head lis : res)

unique :: Eq a => [a] -> [a]
unique a = reverse (shouldBeUnique a [])