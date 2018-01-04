module Main where

import qualified Graphics.Rendering.OpenGL as GL
import qualified Graphics.UI.GLFW          as GLFW

import qualified Util.Shader               as U
import qualified Util.GLFW                 as U

main :: IO ()
main = do
    window <- U.initialize "TODO"
    program <- initResources
    U.mainLoop (draw program window) window
    U.cleanup window

initResources :: IO GL.Program
initResources = undefined -- TODO

draw :: GL.Program -> GLFW.Window -> IO ()
draw = undefined -- TODO