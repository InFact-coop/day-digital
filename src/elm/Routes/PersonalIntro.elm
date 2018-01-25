module Routes.PersonalIntro exposing (..)

import Components.GrayButton exposing (..)
import Components.Questions exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


personalIntro : Model -> Html Msg
personalIntro model =
    div []
        [ questionTemplate model
            ( "Please give us a small personal intro (60 second overview, hobbies, interests, what you enjoy outside of work)"
            , "next-role"
            )
        , grayButton ( "Next Question", "challenging-project" )
        , a [ href "#thank-you" ]
            [ div [ class "tc mb5" ] [ text "No thanks, I just want to send the form" ]
            ]
        ]
