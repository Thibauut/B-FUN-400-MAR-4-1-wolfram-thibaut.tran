{--
-- EPITECH PROJECT, 2022
-- B-FUN-400-MAR-4-1-wolfram-thibaut.tran
-- File description:
-- Main.hs
 --}

module Main (main) where

import System.Environment (getArgs)
import System.Exit (exitWith, ExitCode(ExitSuccess, ExitFailure))
import Text.Read (readMaybe)
import Debug.Trace (trace)

-- flags structure
data Flags = Flags {
    rule :: Maybe Int,
    start :: Maybe Int,
    nbLines :: Maybe Int,
    window :: Maybe Int,
    move :: Maybe Int
}
-- instance Show Flags where
--     show flags = "rule: " ++ show (rule flags) ++ "\n" ++ "start: " ++ show (start flags) ++ "\n" ++ "lines: " ++ show (nbLines flags) ++ "\n" ++ "window: " ++ show (window flags) ++ "\n" ++ "move: " ++ show (move flags)

-- default flags
defaultFlags :: Flags
defaultFlags = Flags {
    rule = Nothing,
    start = Just 0,
    nbLines = Nothing,
    window = Just 80,
    move = Just 0
}

mustFlags :: [String] -> IO ()
mustFlags args =
    if "--rule" `elem` args
    then return ()
    else exitWith (ExitFailure 84)

--parser
checkFlags :: [String] -> Flags -> Maybe Flags
checkFlags [] flags = Just flags
checkFlags (x:xs) flags = case x of
    "--rule" -> checkFlags(tail xs) (flags { rule = (readMaybe(head xs)) })
    "--start" -> checkFlags(tail xs) (flags { start = (readMaybe(head xs)) })
    "--lines" -> checkFlags(tail xs) (flags { nbLines = (readMaybe(head xs)) })
    "--window" -> checkFlags(tail xs) (flags { window = (readMaybe(head xs)) })
    "--move" -> checkFlags(tail xs) (flags { move = (readMaybe(head xs)) })
    _ -> Nothing

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
algo flags = exitWith (ExitSuccess)
-- algo flags = print flags
            -- print (ruleToBits flags) >>
            -- (let r = fromJust (rule flags)
            -- in print (getCellules r [1, 1, 1]))

-- main function
main :: IO ()
main = do
    args <- getArgs
    mustFlags args
    case checkFlags args defaultFlags of
        Just flags -> algo flags >>
                exitWith (ExitSuccess)
        Nothing -> exitWith (ExitFailure 84)
