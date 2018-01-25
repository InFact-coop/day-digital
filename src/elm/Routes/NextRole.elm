module Routes.NextRole exposing (..)

import Components.GrayButton exposing (..)
import Components.Questions exposing (..)
import Helpers exposing (ifThenElse)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


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


videoModal : Model -> Html Msg
videoModal model =
    if model.videoModal then
        div []
            [ videoTag model
            , button [ class "hite w-30-l w-40-m w-60 bg-gray fw2 center mv4 pa3 br4 fw1 f5 no-underline open-sans", onClick <| ToggleVideo model.videoStage ] [ text "record" ]
            ]
    else
        div [] []


videoTag : Model -> Html Msg
videoTag model =
    if model.liveVideoUrl == "" then
        video [ controls True, src model.recordedVideoUrl ] []
    else
        video [ attribute "muted" "true", autoplay True, src model.liveVideoUrl ] []


audioModal : Model -> Html Msg
audioModal model =
    if model.audioModal then
        div []
            [ button [ class "hite w-30-l w-40-m w-60 bg-gray fw2 center mv4 pa3 br4 fw1 f5 no-underline open-sans", onClick <| ToggleAudio model.audioStage ] [ text "record" ]
            ]
    else
        div [] []
