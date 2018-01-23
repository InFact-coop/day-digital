module Routes.Hello exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


hello : Model -> Html Msg
hello model =
    div []
        [ text "Welcome to day digital" ]
