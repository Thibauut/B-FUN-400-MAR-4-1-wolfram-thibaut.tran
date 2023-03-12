{--
-- EPITECH PROJECT, 2022
-- B-FUN-400-MAR-4-1-wolfram-thibaut.tran
-- File description:
-- Utils.hs
--}

module Utils (intToBits, ruleTo8Bits, listToString) where
import Flags

intToBits :: Int -> [Int]
intToBits n = reverse $ bit n
    where
        bit 0 = [0]
        bit 1 = [1]
        bit nbr = (nbr `mod` 2) : bit (nbr `div` 2)

ruleTo8Bits :: Flags -> [Int]
ruleTo8Bits (Flags { rule = Just n }) = pad $ intToBits n
    where
        pad xs = replicate (8 - length xs) 0 ++ xs
ruleTo8Bits _ = []

listToString :: [Int] -> String
listToString [] = ""
listToString (x:xs) | x == 0 = " " ++ listToString xs
                    | x == 1 = "*" ++ listToString xs
                    | otherwise = listToString xs
