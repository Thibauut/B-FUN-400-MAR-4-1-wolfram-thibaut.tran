{--
-- EPITECH PROJECT, 2022
-- B-FUN-400-MAR-4-1-wolfram-thibaut.tran
-- File description:
-- Main.hs
 --}

module Main (main) where

import System.Environment (getArgs)
import System.Exit (exitWith, ExitCode(ExitSuccess, ExitFailure))
import Debug.Trace (trace)
import Data.Maybe (fromJust)
import Flags

mustFlags :: [String] -> IO ()
mustFlags args =
    if "--rule" `elem` args
    then return ()
    else trace "usage: ./wolfram --rule [value]" $ exitWith (ExitFailure 84)

validRule :: Flags -> IO ()
validRule (Flags { rule = Nothing }) =
    trace "Invalid rule." $ exitWith (ExitFailure 84)
validRule (Flags { rule = Just n }) = if n >= 0 && n <= 255
    then return ()
    else trace "Invalid rule." $ exitWith (ExitFailure 84)

-- converti un int en list de bits
intToBits :: Int -> [Int]
intToBits n = reverse $ go n
    where
        go 0 = [0]
        go 1 = [1]
        go nbr = (nbr `mod` 2) : go (nbr `div` 2)

ruleToBits :: Flags -> [Int]
ruleToBits (Flags { rule = Just n }) = pad $ intToBits n
    where
        pad xs = replicate (8 - length xs) 0 ++ xs
ruleToBits _ = []

-- Récupère l'état de la cellule suivante en fonction de l'état actuel et des états des cellules voisines
getCellules :: Int -> [Int] -> Int
getCellules n [a, b, c] = ruleBits !! (7 - (4*a + 2*b + c))
    where
        ruleBits = ruleToBits (Flags { rule = Just n })

algo :: Flags -> IO ()
-- algo flags = exitWith (ExitSuccess)
algo flags =
        validRule flags
--         print flags >>
--             print (ruleToBits flags) >>
--             (let r = fromJust (rule flags)
--             in print (getCellules r [1, 1, 1]))

-- main function
main :: IO ()
main = do
    args <- getArgs
    mustFlags args
    case checkFlags args defaultFlags of
        Just flags -> algo flags >>
                exitWith (ExitSuccess)
        Nothing -> exitWith (ExitFailure 84)
