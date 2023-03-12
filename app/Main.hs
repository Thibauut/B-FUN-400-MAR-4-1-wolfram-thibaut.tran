{--
-- EPITECH PROJECT, 2022
-- B-FUN-400-MAR-4-1-wolfram-thibaut.tran
-- File description:
-- Main.hs
--}

module Main (main) where
import System.Environment (getArgs)
import System.Exit (exitWith, ExitCode(ExitSuccess, ExitFailure))
import Data.Maybe (fromJust)
import Control.Monad (when)
import Flags
import Utils
import Algo

recursAlgo :: [Int] -> [Int] -> Int -> Int -> Int -> IO ()
recursAlgo rule8Bits initialLine 0 lineSize startLine =
    exitWith (ExitSuccess)
recursAlgo rule8Bits initialLine nbLines lineSize startLine =
    let newNbLines = if startLine <= 0 then nbLines - 1 else nbLines
        ruleCheck = wolframRule rule8Bits
        newMap = applyWolframRule ruleCheck initialLine
    in when (startLine <= 0) (putStrLn (listToString initialLine) >>
    recursAlgo rule8Bits newMap newNbLines lineSize (startLine - 1)) >>
    recursAlgo rule8Bits newMap newNbLines lineSize (startLine - 1)


startAlgo :: [Int] -> [Int] -> Maybe Int -> Int -> Int -> IO ()
startAlgo intLine r8Bits Nothing len stLine =
    recursAlgo r8Bits intLine (-1) len stLine
startAlgo intLine r8Bits numLines len stLine =
    recursAlgo r8Bits intLine (fromJust numLines) len stLine

initFirstLine :: Flags -> [Int]
initFirstLine flags = let rule8Bits = fromJust (rule flags)
                          windowSize = fromJust (window flags)
                          moveSize = fromJust (move flags)
                      in makeFirstLine rule8Bits windowSize moveSize

getNumLines :: Flags -> Maybe Int
getNumLines flags = case nbLines flags of
                    Just n -> Just (n)
                    Nothing -> Nothing

algo :: Flags -> IO ()
algo flags =
        validRule flags >>
        let initialLine = initFirstLine flags
        in  let rule8Bits = ruleTo8Bits flags
                numLines = getNumLines flags
                startLine = fromJust (start flags)
                lineSize = length initialLine
            in startAlgo initialLine rule8Bits numLines lineSize startLine


main :: IO ()
main = do
    args <- getArgs
    mustFlags args
    case checkFlags args defaultFlags of
        Just flags -> algo flags >>
            exitWith (ExitSuccess)
        Nothing -> exitWith (ExitFailure 84)
