module Types exposing (..)

import Navigation


-- Model


type Route
    = Home
    | AboutYou
    | FourOhFour
    | NextRole
    | ThankYou


type alias Model =
    { route : Route
    , videoStage : Stage
    , videoMessage : String
    , messageLength : Int
    , paused : Bool
    }


type Stage
    = StagePreRecord
    | StageRecording
    | StageRecordStopped
    | StageRecordError



-- Update


type Msg
    = NoOp
    | UrlChange Navigation.Location
    | RecordStart String
    | RecordStop String
    | RecordError String
    | RecieveVideo String
    | ToggleVideo Stage
    | Increment
