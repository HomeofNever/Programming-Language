{-|
    interpret(x) = x
    interpret(\x.E1) = let f = interpret(E1)
                        -> \x.f
    interpret(E1 E2) = let f = interpret(E1)
                            a = interpret(E2)
                        in case f of 
                            \x.E3 -> interpret(E3[a/x])
                            _ -> f a
-}
module Interpreter where
import Control.Exception
import Debug.Trace
import Data.List

---- Data types ----

type Name = String

data Expr = 
  Var Name
  | Lambda Name Expr
  | App Expr Expr
  deriving 
    (Eq,Show)


---- Functions ----
removeSpecificElement _ [] = []
removeSpecificElement x (y:ys) | x == y = removeSpecificElement x ys
                              | otherwise = y : removeSpecificElement x ys

freeVars::Expr -> [Name]
freeVars e = case e of
  Var n -> n:[]
  Lambda n e1 -> removeSpecificElement n (freeVars e1)
  App e1 e2 -> union (freeVars e1) (freeVars e2)

freshVars::[Expr]->[Name]
freshVars expr_li = 
  foldl (\ls currE -> ls \\ (freeVars currE)) [show x ++ "_" | x <- [1..]] expr_li

subst::(Name,Expr) -> Expr -> Expr 
-- \xE M
subst (n, e) exp = 
  case exp of
    Var x -> if (x == n)
              then e
            else exp
    App e1 e2 -> (App ((subst (n, e)) e1) ((subst (n, e)) e2))   
    Lambda n1 e1 -> if (n1 == n)
                      then (Lambda n1 e1)
                    else let freeV = head (freshVars [e1, e, (Var n)]) in 
                      (Lambda freeV (subst(n, e) (subst (n1, (Var freeV)) e1)))

appNF_OneStep::Expr -> Maybe Expr
appNF_OneStep exp = 
  case exp of
    Var x -> Nothing
    Lambda n e -> let 
      e1 = appNF_OneStep e 
        in case e1 of
          Just en -> Just (Lambda n en)
          _ -> Nothing
    App e1 e2 -> let ex = appNF_OneStep e1
        in case ex of 
          Nothing -> let ey = appNF_OneStep e2 
            in case ey of
              Nothing -> case e1 of 
                Lambda n e -> Just (subst (n, e2) e)
                _ -> Nothing
              Just en -> Just (App e1 en)
          Just en -> Just (App en e2)


appNF_n::Int -> Expr -> Expr
appNF_n i e = case i of
  0 -> e
  _ -> let en = appNF_OneStep e
        in case en of 
          Just x -> appNF_n (i - 1) x
          _ -> e