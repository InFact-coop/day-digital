module Routes.Video exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


videoRoute : Model -> Html Msg
videoRoute model =
    div []
        [ h3 [ id "status" ]
            []
        , input [ id "record", type_ "button", value "record", onClick (ToggleVideo StagePreRecord) ]
            []
        , text ""
        , input [ id "stop", type_ "button", value "stop", onClick (ToggleVideo StageRecording) ]
            []
        , text ""
        ]
