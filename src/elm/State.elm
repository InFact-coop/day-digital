port module State exposing (..)

import Dom.Scroll exposing (..)
import Task
import Time exposing (Time, second)
import Types exposing (..)


-- MODEL


initModel : Model
initModel =
    { route = ThankYou
    , videoStage = StagePreRecord
    , videoMessage = ""
    , messageLength = 0
    , paused = True
    }



--UPDATE


getRoute : String -> Route
getRoute hash =
    case hash of
        "#home" ->
            Home

        "#about-you" ->
            AboutYou

        "#nextRole" ->
            NextRole

        "#thank-you" ->
            ThankYou

        _ ->
            FourOhFour


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            if model.messageLength >= 30 then
                model
                    |> update (ToggleVideo StageRecording)
            else
                ( { model | messageLength = model.messageLength + 1 }, Cmd.none )

        RecordStart string ->
            ( model, recordStart string )

        RecordStop string ->
            ( model, recordStop string )

        RecieveVideo string ->
            ( { model | videoMessage = string }, Cmd.none )

        RecordError err ->
            ( { model | videoStage = StageRecordError }, Cmd.none )

        ToggleVideo stage ->
            case stage of
                StageRecordError ->
                    ( { model | videoStage = StageRecordError }, Cmd.none )

                StageRecordStopped ->
                    ( { model | videoStage = StagePreRecord }, Cmd.none )

                StageRecording ->
                    ( { model | videoStage = StageRecordStopped }, recordStop "yes" )

                StagePreRecord ->
                    ( { model | videoStage = StageRecording }, recordStart "yes" )

        UrlChange location ->
            ( { model | route = getRoute location.hash }, Task.attempt (always NoOp) (toTop "container") )

        NoOp ->
            ( model, Cmd.none )


port recordStart : String -> Cmd msg


port recordStop : String -> Cmd msg


port recordError : (String -> msg) -> Sub msg


port videoUrl : (String -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ videoUrl RecieveVideo
        , recordError RecordError
        , if not model.paused then
            Time.every second (always Increment)
          else
            Sub.none
        ]
