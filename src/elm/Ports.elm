port module Ports exposing (..)


port recordStart : () -> Cmd msg


port recordStop : () -> Cmd msg


port prepareVideo : () -> Cmd msg


port confirmRecording : () -> Cmd msg


port recordError : (String -> msg) -> Sub msg


port videoUrl : (String -> msg) -> Sub msg
