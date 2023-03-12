{--
-- EPITECH PROJECT, 2022
-- B-FUN-400-MAR-4-1-wolfram-thibaut.tran
-- File description:
-- Algo.hs
--}

module Algo (makeFirstLine, wolframRule, applyWolframRule) where

wolframRule :: [Int] -> (Int -> Int -> Int -> Int)
wolframRule rule8Bits cell left right =
    let num = left*4 + cell*2 + right
    in rule8Bits !! (7 - num)

applyWolframRule :: (Int -> Int -> Int -> Int) -> [Int] -> [Int]
applyWolframRule rule list =
    map (local list) [0..maxListSize]
    where
        local list index =
            let len = length list
                cell = (!!) list index
                left = (!!) list $ mod (index + len - 1) len
                right = (!!) list $ mod (index + 1) len
            in rule cell left right
        maxListSize = length list - 1

makeFirstLine :: Int -> Int -> Int -> [Int]
makeFirstLine rule win move = replicate (win `div` 2 + move) 0 ++
                                [1] ++ replicate (((win `div` 2) - 1) - move) 0
