module Types exposing (..)

import Navigation
import Html exposing (..)


-- Model


type Route
    = Hello


type alias Model =
    { route : Route }



-- Update


type Msg
    = NoOp
    | UrlChange Navigation.Location
