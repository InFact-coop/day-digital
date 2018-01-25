module Routes.ChallengingProject exposing (..)

import Components.GrayButton exposing (..)
import Components.Questions exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


challengingProject : Model -> Html Msg
challengingProject model =
    div []
        [ questionTemplate model
            ( "What was the most challenging project you have worked on, and how did you contribute?"
            , "personal-intro"
            )
        , grayButton ( "Submit", "thank-you" )
        ]
