module Util.GLFW where

-- based on https://github.com/bergey/haskell-OpenGL-examples/blob/master/src/Util/GLFW.hs

import           Control.Monad    (when, unless)
import qualified Graphics.UI.GLFW as GLFW
import           System.Exit      (exitFailure, exitSuccess)
import           System.IO        (hPutStrLn, stderr)

errorCallback :: GLFW.ErrorCallback
errorCallback _ = hPutStrLn stderr

keyCallback :: GLFW.KeyCallback
keyCallback window key _ action _ =
    when (key == GLFW.Key'Escape && action == GLFW.KeyState'Pressed) $
        GLFW.setWindowShouldClose window True

initialize :: String -> IO GLFW.Window
initialize title = do
    GLFW.setErrorCallback (Just errorCallback)
    successfulInit <- GLFW.init
    if not successfulInit
        then exitFailure
        else do
            GLFW.windowHint (GLFW.WindowHint'ContextVersionMajor 2)
            GLFW.windowHint (GLFW.WindowHint'ContextVersionMinor 1)
            GLFW.windowHint (GLFW.WindowHint'Samples 4)
            mw <- GLFW.createWindow 640 640 title Nothing Nothing
            maybe exitNow finishInit mw
  where
    exitNow = GLFW.terminate >> exitFailure
    finishInit window = do
        GLFW.makeContextCurrent (Just window)
        GLFW.setKeyCallback window (Just keyCallback)
        return window

cleanup :: GLFW.Window -> IO ()
cleanup window = do
    GLFW.destroyWindow window
    GLFW.terminate
    exitSuccess

mainLoop :: IO () -> GLFW.Window -> IO ()
mainLoop draw window = do
    close <- GLFW.windowShouldClose window
    unless close $ do
        draw
        GLFW.swapBuffers window
        GLFW.pollEvents
        mainLoop draw window