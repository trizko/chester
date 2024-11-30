module Main where

type PlayerTimer = Int
data Side = White | Black deriving Show
data Game = Game { white :: PlayerTimer, black :: PlayerTimer, side :: Side } deriving Show

main :: IO ()
main = putStrLn "Hello, Haskell!"
