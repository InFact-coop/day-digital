port module Ports exposing (..)


port recordStart : () -> Cmd msg


port recordStop : () -> Cmd msg


port prepareVideo : () -> Cmd msg


port prepareAudio : () -> Cmd msg


port confirmRecording : () -> Cmd msg


port recordError : (String -> msg) -> Sub msg


port recordedVideoUrl : (String -> msg) -> Sub msg


port liveVideoUrl : (String -> msg) -> Sub msg


port audioUrl : (String -> msg) -> Sub msg
