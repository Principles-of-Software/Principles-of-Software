-- Question 1:
--    interpret(x) = x
--    interpret(\x.E1) = let f = interpret(E1)
--                        -> \x.f
--    interpret(E1 E2) = let f = interpret(E1)
--                            a = interpret(E2)
--                        in case f of
--                            \x.E3 -> interpret(E3[a/x])
--                            _ -> f a
module Interpreter where

import Control.Exception
import Data.List
import Debug.Trace

---- Data types ----

type Name = String

data Expr
  = Var Name
  | Lambda Name Expr
  | App Expr Expr
  deriving
    (Eq, Show)

---- Helpers ----

-- Purpose: Remove all occurance of an element from a list
-- Example: removeSpecificElement 1 [1, 2, 3, 1] should produce [2, 3]
-- Definition:
removeSpecificElement :: Eq a => a -> [a] -> [a]
removeSpecificElement _ [] = []
removeSpecificElement x (h : ls) =
  if x == h
    then removeSpecificElement x ls
    else h : removeSpecificElement x ls

---- Functions ----

-- Purpose: Takes an expression expr and returns the list of variables
--          that are free in expr without repetition
-- Example: freeVars (App (Var "x") (Var "x")) should produce ["x"]
-- Definition:
freeVars :: Expr -> [Name]
freeVars e = case e of
  Var n -> [n]
  Lambda n e1 -> removeSpecificElement n (freeVars e1)
  App e1 e2 -> freeVars e1 `union` freeVars e2

-- Purpose: Takes a list of expressions and generates
--          an (infinite) list of variables that are not free
--          in any of the expressions in the list that are free
--          in expr without repetition
-- Example: freshVars [Lambda "1_" (App (Var "x") (App (Var "1_") (Var "2_")))]
--          should produce the _infinite_ list [1_,3_,4_,5_,..]
-- Definition:
freshVars :: [Expr] -> [Name]
freshVars expr_li =
  foldl
    (\ls currE -> ls \\ freeVars currE)
    [show x ++ "_" | x <- [1 ..]]
    expr_li

-- Purpose: Takes a variable x and an expression e,
--          and returns a function that takes an
--          expression E and returns E[e/x]
-- Example: subst ("x", Var "y") (App (Var "x") (Lambda "x" (Var "x")))
--          should produce App (Var "y") (Lambda "x" (Var "x"))
-- Definition:
subst :: (Name, Expr) -> Expr -> Expr
subst (n, e) exp =
  case exp of
    Var x -> if x == n then e else exp
    App e1 e2 -> App (subst (n, e) e1) (subst (n, e) e2)
    Lambda n1 e1 ->
      if n1 == n
        then Lambda n1 e1
        else
          let freeV = head (freshVars [e1, e, Var n])
           in Lambda freeV (subst (n, e) (subst (n1, Var freeV) e1))

-- Purpose: Takes an expression e. If there is a redex
--          available in e, it picks the correct applicative
--          order redex and reduces e by one step. Otherwise
--          it returns Nothing
-- Example: appNF_OneStep (App (Var "x") (Lambda "x" (Var "x")))
--          should produce Nothing
-- Definition:
appNF_OneStep :: Expr -> Maybe Expr
appNF_OneStep exp =
  case exp of
    Var _ -> Nothing
    Lambda n e ->
      let e1 = appNF_OneStep e
       in case e1 of
            Just en -> Just (Lambda n en)
            _ -> Nothing
    App e1 e2 ->
      let ex = appNF_OneStep e1
       in case ex of
            Nothing ->
              let ey = appNF_OneStep e2
               in case ey of
                    Nothing -> case e1 of
                      Lambda n e -> Just (subst (n, e2) e)
                      _ -> Nothing
                    Just en -> Just (App e1 en)
            Just en -> Just (App en e2)

-- Purpose: Given an integer n and an expression e,
--          appNF_n does n reductions (or as many as possible)
--          and returns the resulting expression
-- Example: appNF_n 999 (App (Lambda "x" (Var "x")) (Var "x"))
--          should produce Var "x"
appNF_n :: Int -> Expr -> Expr
appNF_n i e = case i of
  0 -> e
  _ ->
    let en = appNF_OneStep e
     in case en of
          Just x -> appNF_n (i - 1) x
          _ -> e