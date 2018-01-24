module Components.RecordVideoButton exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Types exposing (..)


recordVideoButton : Model -> Html Msg
recordVideoButton model =
    let
        ( image, content ) =
            toggleVideoButton model.videoStage
    in
        div [ class "w-50-ns w-100 mid-gray flex flex-column mv2 pointer", onClick <| ToggleVideo model.videoStage ]
            [ img [ src image, class "h5 mb2" ] []
            , text content
            ]


toggleVideoButton : Stage -> ( String, String )
toggleVideoButton stage =
    case stage of
        StagePreRecord ->
            ( "./assets/rec_video.svg", "Click to Record Video" )

        StageRecording ->
            ( "./assets/recording.svg", "Recording..." )

        StageRecordStopped ->
            ( "./assets/recording_stopped.svg", "Recording stopped" )

        StageRecordError ->
            ( "./assets/recording_error.svg", "Recording error" )
