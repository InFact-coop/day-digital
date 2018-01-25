module Routes.ChallengingProject exposing (..)

import Components.Media exposing (..)
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
        , div [ class "white w-30-l w-40-m w-60 bg-gray fw2 center mv4 pa3 br4 fw1 f5 no-underline open-sans", onClick SendForm ] [ text "Submit" ]
        , videoModal model
        , audioModal model
        ]
