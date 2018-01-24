module Routes.NextRole exposing (..)

import Components.Questions exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


nextRole : Model -> Html Msg
nextRole model =
    div []
        [ questionTemplate model
            ( "What are you looking for in your next role?"
            , "aboutYou"
            )
        ]
