module State exposing (..)

import Dom.Scroll exposing (..)
import Ports exposing (..)
import Router exposing (getRoute)
import Task
import Time exposing (Time, second)
import Types exposing (..)
import Helpers exposing (..)


initModel : Model
initModel =
    { route = Home
    , videoStage = StagePreRecord
    , audioStage = StagePreRecord
    , liveVideoUrl = ""
    , messageLength = 0
    , paused = True
    , videoModal = False
    , audioModal = False
    , recordedVideoUrl = ""
    }



-- TODO what is messageLength?


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            if model.messageLength >= 30 then
                model
                    |> update (ToggleVideo StageRecording)
            else
                ( { model | messageLength = model.messageLength + 1 }, Cmd.none )

        RecordStart ->
            ( model, recordStart () )

        RecordStop ->
            ( model, recordStop () )

        ReceiveRecordedVideoUrl string ->
            ( { model | recordedVideoUrl = string, liveVideoUrl = "" }, Cmd.none )

        ReceiveLiveVideoUrl string ->
            ( { model | liveVideoUrl = string, recordedVideoUrl = "" }, Cmd.none )

        RecordError err ->
            ( { model | videoStage = StageRecordError }, Cmd.none )

        ToggleVideo stage ->
            case stage of
                StageRecordError ->
                    ( { model | videoStage = StageRecordError }, Cmd.none )

                StageRecordStopped ->
                    ( { model | videoStage = StagePreRecord }, Cmd.none )

                StageRecording ->
                    ( { model | videoStage = StageRecordStopped }, recordStop () )

                StagePreRecord ->
                    ( { model | videoStage = StageRecording }, recordStart () )

        ToggleAudio stage ->
            case stage of
                StageRecordError ->
                    ( { model | audioStage = StageRecordError }, Cmd.none )

                StageRecordStopped ->
                    ( { model | audioStage = StagePreRecord }, Cmd.none )

                StageRecording ->
                    ( { model | audioStage = StageRecordStopped }, recordStop () )

                StagePreRecord ->
                    ( { model | audioStage = StageRecording }, recordStart () )

        UrlChange location ->
            ( { model | route = getRoute location.hash }, Task.attempt (always NoOp) (toTop "container") )

        PrepareVideo ->
            { model | videoModal = True } ! [ prepareVideo () ]

        PrepareAudio ->
            { model | audioModal = True } ! [ prepareAudio () ]

        NoOp ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ recordedVideoUrl ReceiveRecordedVideoUrl
        , recordError RecordError
        , ifThenElse (not model.paused) (Time.every second (always Increment)) Sub.none
        , liveVideoUrl ReceiveLiveVideoUrl
        ]
