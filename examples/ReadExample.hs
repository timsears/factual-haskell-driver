module Main where

import System.Environment (getArgs)
import Network.Factual.API
import Data.Factual.Query.ReadQuery
import Data.Factual.Response

main :: IO()
main = do
  args <- getArgs
  let oauthKey = head args
  let oauthSecret = last args
  let token = generateToken oauthKey oauthSecret
  let query = ReadQuery { table = Places
                        , search = AndSearch []
                        , select = ["name"]
                        , limit = Just 50
                        , offset = Nothing
                        , includeCount = True
                        , geo = Just (Circle 34.06021 (-118.41828) 5000.0)
                        , filters = [EqualStr "name" "Stand"] }
  result <- makeRequest token query
  putStrLn $ "Status: " ++ status result
  putStrLn $ "Version: " ++ show (version result)
  putStrLn $ "Data: " ++ show (response result)
