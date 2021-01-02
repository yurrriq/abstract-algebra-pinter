module Pinter.Ch03.CoinGame where

import Control.Arrow (first, second)
import Data.Group (Group (..))
import Data.Tuple (swap)

data Move
  = -- | Flip over the coin at A.
    M1
  | -- | Flip over the coin at B.
    M2
  | -- | Flip over both coins.
    M3
  | -- | Switch the coins.
    M4
  | -- | Flip coin at A; then switch.
    M5
  | -- | Flip coin at B; then switch.
    M6
  | -- | Flip both coins; then switch.
    M7
  | -- | Do not change anything.
    I
  deriving (Eq, Show)

instance Semigroup Move where
  I <> b = b
  b <> I = b
  M1 <> M1 = I
  M1 <> M2 = M3
  M1 <> M3 = M2
  M1 <> M4 = M5
  M1 <> M5 = M4
  M1 <> M6 = M7
  M1 <> M7 = M6
  M2 <> M1 = M3
  M2 <> M2 = I
  M2 <> M3 = M1
  M2 <> M4 = M6
  M2 <> M5 = M7
  M2 <> M6 = M4
  M2 <> M7 = M5
  M3 <> M1 = M2
  M3 <> M2 = M1
  M3 <> M3 = I
  M3 <> M4 = M7
  M3 <> M5 = M6
  M3 <> M6 = M5
  M3 <> M7 = M4
  M4 <> M1 = M6
  M4 <> M2 = M5
  M4 <> M3 = M7
  M4 <> M4 = I
  M4 <> M5 = M2
  M4 <> M6 = M1
  M4 <> M7 = M3
  M5 <> M1 = M7
  M5 <> M2 = M4
  M5 <> M3 = M6
  M5 <> M4 = M1
  M5 <> M5 = M3
  M5 <> M6 = I
  M5 <> M7 = M2
  M6 <> M1 = M4
  M6 <> M2 = M7
  M6 <> M3 = M5
  M6 <> M4 = M2
  M6 <> M5 = I
  M6 <> M6 = M3
  M6 <> M7 = M1
  M7 <> M1 = M5
  M7 <> M2 = M6
  M7 <> M3 = M4
  M7 <> M4 = M3
  M7 <> M5 = M1
  M7 <> M6 = M2
  M7 <> M7 = I

instance Monoid Move where
  mempty = I

instance Group Move where
  invert M5 = M6
  invert M6 = M5
  invert x = x

runMove :: Move -> (Bool, Bool) -> (Bool, Bool)
runMove M1 = first not
runMove M2 = second not
runMove M3 = runMove M1 . runMove M2
runMove M4 = swap
runMove M5 = runMove M4 . runMove M1
runMove M6 = runMove M4 . runMove M2
runMove M7 = runMove M4 . runMove M1 . runMove M2
runMove I = id
