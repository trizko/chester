module Main where

type PlayerTimer = Int
data Side = White | Black deriving Show
data Game = Game { white :: PlayerTimer, black :: PlayerTimer, side :: Side } deriving Show

decrement :: Game -> Game
decrement (Game w b White) = Game { white = w - 1, black = b, side = White}
decrement (Game w b Black) = Game { white = w, black = b - 1, side = Black}

toggleTurn :: Game -> Game
toggleTurn (Game w b White) = Game { white = w, black = b, side = Black}
toggleTurn (Game w b Black) = Game { white = w, black = b, side = White}

main :: IO ()
main = putStrLn "Hello, Haskell!"
