module Routes.NextRole exposing (..)

import Components.GrayButton exposing (..)
import Components.Questions exposing (..)
import Helpers exposing (ifThenElse)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import Components.Media exposing (..)


nextRole : Model -> Html Msg
nextRole model =
    div []
        [ questionTemplate model
            ( "What are you looking for in your next role?"
            , "about-you"
            )
        , grayButton ( "Next Question", "personal-intro" )
        , a [ href "#thank-you" ]
            [ div [ class "tc mb5" ] [ text "No thanks, I just want to send the form" ]
            ]
        , videoModal model
        , audioModal model
        ]
