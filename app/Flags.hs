{--
-- EPITECH PROJECT, 2022
-- B-FUN-400-MAR-4-1-wolfram-thibaut.tran
-- File description:
-- Flags.hs
--}

module Flags (Flags(..), defaultFlags, checkFlags) where
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

instance Show Flags where
    show flags = "rule: " ++ show (rule flags) ++ "\n" ++ "start: " ++ show (start flags) ++ "\n" ++ "lines: " ++ show (nbLines flags) ++ "\n" ++ "window: " ++ show (window flags) ++ "\n" ++ "move: " ++ show (move flags)

-- default flags
defaultFlags :: Flags
defaultFlags = Flags {
    rule = Nothing,
    start = Just 0,
    nbLines = Nothing,
    window = Just 80,
    move = Just 0
}

checkFlags5 :: [String] -> Flags -> Maybe Flags
checkFlags5 [] flags = Just flags
checkFlags5 (x:xs) flags = case x of
    "--move" -> case xs of
        [] -> trace "Invalid argument." $ Nothing
        (m:ms) -> case readMaybe m of
            Just n -> checkFlags ms (flags { move = Just n })
            Nothing -> trace "Invalid argument." $ Nothing
    _ -> trace "Invalid option." $ Nothing

checkFlags4 :: [String] -> Flags -> Maybe Flags
checkFlags4 [] flags = Just flags
checkFlags4 (x:xs) flags = case x of
    "--window" -> case xs of
        [] -> trace "Invalid argument." $ Nothing
        (y:ys) -> case readMaybe y of
            Just n -> checkFlags ys (flags { start = Just n })
            Nothing -> trace "Invalid argument." $ Nothing
    _ -> checkFlags5 (x:xs) flags

checkFlags3 :: [String] -> Flags -> Maybe Flags
checkFlags3 [] flags = Just flags
checkFlags3 (x:xs) flags = case x of
    "--lines" -> case xs of
        [] -> trace "Invalid argument." $ Nothing
        (y:ys) -> case readMaybe y of
            Just n -> checkFlags ys (flags { start = Just n })
            Nothing -> trace "Invalid argument." $ Nothing
    _ -> checkFlags4 (x:xs) flags

checkFlags2 :: [String] -> Flags -> Maybe Flags
checkFlags2 [] flags = Just flags
checkFlags2 (x:xs) flags = case x of
    "--start" -> case xs of
        [] -> trace "Invalid argument." $ Nothing
        (y:ys) -> case readMaybe y of
            Just n -> checkFlags ys (flags { start = Just n })
            Nothing -> trace "Invalid argument." $ Nothing
    _ -> checkFlags3 (x:xs) flags

checkFlags :: [String] -> Flags -> Maybe Flags
checkFlags [] flags = Just flags
checkFlags (x:xs) flags = case x of
    "--rule" -> case xs of
        [] -> trace "Invalid argument." $ Nothing
        (y:ys) -> case readMaybe y of
            Just n -> checkFlags ys (flags { rule = Just n })
            Nothing -> trace "Invalid argument." $ Nothing
    _ -> checkFlags2 (x:xs) flags
