module Types exposing (..)

import Navigation


-- Model


type Route
    = Home
    | AboutYou
    | FourOhFour
    | NextRole
    | ThankYou
    | PersonalIntro
    | ChallengingProject


type alias Model =
    { route : Route
    , videoStage : Stage
    , audioStage : Stage
    , videoMessage : String
    , messageLength : Int
    , paused : Bool
    , videoModal : Bool
    , audioModal : Bool
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
    | RecordStart
    | RecordStop
    | RecordError String
    | RecieveVideo String
    | ToggleVideo Stage
    | ToggleAudio Stage
    | Increment
    | PrepareVideo
    | PrepareAudio
