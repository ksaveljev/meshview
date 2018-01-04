module Util.Shader where

import           Control.Monad             (unless)
import qualified Data.ByteString           as B
import qualified Graphics.Rendering.OpenGL as GL
import           Graphics.Rendering.OpenGL (($=))
import           System.Exit               (exitFailure)
import           System.IO                 (hPutStrLn, stderr)

compileProgram :: B.ByteString -> B.ByteString -> IO GL.Program
compileProgram = undefined -- TODO

compileShader :: B.ByteString -> GL.ShaderType -> IO GL.Shader
compileShader shaderSrc shaderType = do
    shader <- GL.createShader shaderType
    GL.shaderSourceBS shader $= shaderSrc
    GL.compileShader shader
    ok <- GL.get (GL.compileStatus shader)
    unless ok $ do
        hPutStrLn stderr =<< GL.get (GL.shaderInfoLog shader)
        exitFailure
    return shader