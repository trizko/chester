module Main where

import Control.Concurrent (forkIO, threadDelay)
import Control.Monad (forever, when)
import System.IO (hSetBuffering, BufferMode(NoBuffering), hReady, stdin)

type PlayerTimer = Int
data Side = White | Black deriving Show
data Game = Game { white :: PlayerTimer, black :: PlayerTimer, side :: Side } deriving Show

decrement :: Game -> Game
decrement (Game w b White) = Game { white = w - 1, black = b, side = White }
decrement (Game w b Black) = Game { white = w, black = b - 1, side = Black }

toggleTurn :: Game -> Game
toggleTurn (Game w b White) = Game { white = w, black = b, side = Black }
toggleTurn (Game w b Black) = Game { white = w, black = b, side = White }

nonBlockingGetChar :: IO (Maybe Char)
nonBlockingGetChar = do
    ready <- hReady stdin
    if ready
        then Just <$> getChar
        else return Nothing


playTurn :: Game -> IO ()
playTurn game = do
    print game
    when (white game > 0 && black game > 0) $ do
        threadDelay 1000000
        let newGame = decrement game
        playTurn newGame

main :: IO ()
main = do
    let game = Game { white = 10, black = 10, side = White }
    putStrLn "Starting the chess timer. Press space bar to toggle turns."
    playTurn game
