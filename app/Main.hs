module Main where

import Control.Monad.State (StateT, get, modify, liftIO, evalStateT, when)
import Control.Concurrent (threadDelay)
import System.IO (hSetBuffering, BufferMode(NoBuffering), hReady, stdin)

type PlayerTimer = Int
data Side = White | Black deriving Show
data Game = Game { white :: PlayerTimer, black :: PlayerTimer, side :: Side } deriving Show
type GameState = StateT Game IO ()

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

gameLoop :: GameState
gameLoop = do
    game <- get
    liftIO $ print game

    when (white game > 0 && black game > 0) $ do
        liftIO $ threadDelay 1000000
        modify decrement

        input <- liftIO nonBlockingGetChar
        case input of
            Just ' ' -> do
                modify toggleTurn
            _ -> return ()

        gameLoop

runGame :: Game -> IO ()
runGame initialGame = do
    hSetBuffering stdin NoBuffering
    evalStateT gameLoop initialGame

main :: IO ()
main = do
    let game = Game { white = 600, black = 600, side = White }
    putStrLn "Starting the chess timer. Press space bar to toggle turns."
    runGame game
