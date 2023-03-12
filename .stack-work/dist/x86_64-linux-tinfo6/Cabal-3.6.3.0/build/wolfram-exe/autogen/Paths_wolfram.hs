{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_wolfram (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/workspace/Epitech/TEK2/delivery/B-FUN-400-MAR-4-1-wolfram-thibaut.tran/.stack-work/install/x86_64-linux-tinfo6/5027774c91c2e4d26ee6fec3340e731cdb0d1a9c6e19fc42be615f3fea9b611d/9.2.5/bin"
libdir     = "/workspace/Epitech/TEK2/delivery/B-FUN-400-MAR-4-1-wolfram-thibaut.tran/.stack-work/install/x86_64-linux-tinfo6/5027774c91c2e4d26ee6fec3340e731cdb0d1a9c6e19fc42be615f3fea9b611d/9.2.5/lib/x86_64-linux-ghc-9.2.5/wolfram-0.1.0.0-B3pGMMA51SkE2HaUboXN5k-wolfram-exe"
dynlibdir  = "/workspace/Epitech/TEK2/delivery/B-FUN-400-MAR-4-1-wolfram-thibaut.tran/.stack-work/install/x86_64-linux-tinfo6/5027774c91c2e4d26ee6fec3340e731cdb0d1a9c6e19fc42be615f3fea9b611d/9.2.5/lib/x86_64-linux-ghc-9.2.5"
datadir    = "/workspace/Epitech/TEK2/delivery/B-FUN-400-MAR-4-1-wolfram-thibaut.tran/.stack-work/install/x86_64-linux-tinfo6/5027774c91c2e4d26ee6fec3340e731cdb0d1a9c6e19fc42be615f3fea9b611d/9.2.5/share/x86_64-linux-ghc-9.2.5/wolfram-0.1.0.0"
libexecdir = "/workspace/Epitech/TEK2/delivery/B-FUN-400-MAR-4-1-wolfram-thibaut.tran/.stack-work/install/x86_64-linux-tinfo6/5027774c91c2e4d26ee6fec3340e731cdb0d1a9c6e19fc42be615f3fea9b611d/9.2.5/libexec/x86_64-linux-ghc-9.2.5/wolfram-0.1.0.0"
sysconfdir = "/workspace/Epitech/TEK2/delivery/B-FUN-400-MAR-4-1-wolfram-thibaut.tran/.stack-work/install/x86_64-linux-tinfo6/5027774c91c2e4d26ee6fec3340e731cdb0d1a9c6e19fc42be615f3fea9b611d/9.2.5/etc"

getBinDir     = catchIO (getEnv "wolfram_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "wolfram_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "wolfram_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "wolfram_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "wolfram_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "wolfram_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
