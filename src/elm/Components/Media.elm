module Components.Media exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


modalText : Stage -> String
modalText stage =
    case stage of
        StagePreRecord ->
            "Click to Record"

        StageRecording ->
            "Click to Stop"

        StageRecordStopped ->
            "Click to Restart"

        StageRecordError ->
            "Error!"


videoModal : Model -> Html Msg
videoModal model =
    if model.videoModal then
        div [ class "w-90 h-90" ]
            [ videoTag model
            , button [ class "b white w-30-l w-40-m w-60 bg-gray fw2 center mv4 pa3 br4 fw1 f5 no-underline open-sans", onClick <| ToggleVideo model.videoStage ] [ text <| modalText model.videoStage ]
            ]
    else
        div
            [ class "dn" ]
            []


sendQuestion : Route -> Msg
sendQuestion route =
    case route of
        NextRole ->
            UploadQuestion "q1"

        PersonalIntro ->
            UploadQuestion "q2"

        ChallengingProject ->
            UploadQuestion "q3"

        _ ->
            NoOp



-- resetVideo : Html Msg
-- resetVideo =
--     button [ onClick PrepareVideo ] [ text "RESET VIDEO" ]


videoTag : Model -> Html Msg
videoTag model =
    if model.liveVideoUrl == "" then
        div []
            [ video [ controls True, src model.recordedVideoUrl ] []
            , button [ onClick <| sendQuestion model.route ] [ text "HELLO HERE IS A BUTTON" ]
            ]
    else
        div []
            [ video [ attribute "muted" "true", autoplay True, src model.liveVideoUrl ] []
            ]


audioModal : Model -> Html Msg
audioModal model =
    if model.audioModal then
        div []
            [ button [ class "hite w-30-l w-40-m w-60 bg-gray fw2 center mv4 pa3 br4 fw1 f5 no-underline open-sans", onClick <| ToggleAudio model.audioStage ] [ text "record" ]
            ]
    else
        div [] []
