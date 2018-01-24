module Routes.Hello exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


hello : Model -> Html Msg
hello model =
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
