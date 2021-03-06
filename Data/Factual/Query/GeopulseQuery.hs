-- | This module exports the type used to create geopulse queries.
module Data.Factual.Query.GeopulseQuery
  (
    -- * ResolveQuery type
    GeopulseQuery(..)
    -- * Required modules
  , module Data.Factual.Shared.Geo
  ) where

import Data.Factual.Query
import Data.Factual.Utils
import Data.Factual.Shared.Geo

-- | The GeopulseQuery type is used to construct geopulse queries. A geo point
--   is required but select values are optional (just use an empty list to
--   denote selecting all pulses).
data GeopulseQuery = GeopulseQuery { geo    :: Geo
                                   , select :: [String]
                                   } deriving (Eq, Show)

-- The GeopulseQuery type is a member of the Query typeclass so it can be used
-- to make a request.
instance Query GeopulseQuery where
  toPath query = "/places/geopulse?"
               ++ joinAndFilter [ geoString $ Just $ geo query
                                , selectString $ select query ]
