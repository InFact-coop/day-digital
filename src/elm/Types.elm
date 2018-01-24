module Types exposing (..)

import Html exposing (..)
import Navigation


-- Model


type Route
    = HelloRoute
    | AboutYouRoute


type alias Model =
    { route : Route }



-- Update


type Msg
    = NoOp
    | UrlChange Navigation.Location
