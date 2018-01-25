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
    , liveVideoUrl : String
    , recordedVideoUrl : String
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
    | ReceiveRecordedVideoUrl String
    | ReceiveLiveVideoUrl String
    | ToggleVideo Stage
    | ToggleAudio Stage
    | Increment
    | PrepareVideo
    | PrepareAudio
