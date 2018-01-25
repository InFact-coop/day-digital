module State exposing (..)

import Dom.Scroll exposing (..)
import Ports exposing (..)
import Router exposing (getRoute)
import Task
import Time exposing (Time, second)
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Http exposing (..)
import Json.Decode as Decode
import Json.Encode as Encode
import Types exposing (..)
import Commands exposing (..)
import Helpers exposing (..)


initForm : Form
initForm =
    Form "" "" "" "" "" "" "" "" 0 0 "" "" "" "" "" "" "" ""


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
    , airtableForm = initForm
    , formSent = NotSent
    }



-- TODO what is messageLength?


createNewForm : Form -> FormField -> String -> Form
createNewForm currentForm fieldType content =
    case fieldType of
        Name ->
            { currentForm | name = content }

        ContactNumber ->
            { currentForm | contactNumber = content }

        Email ->
            { currentForm | email = content }

        Role ->
            { currentForm | role = content }

        RoleOther ->
            { currentForm | roleOther = content }

        StartDate ->
            { currentForm | startDate = content }

        ContractLength ->
            { currentForm | contractLength = content }

        ContractOther ->
            { currentForm | contractOther = content }

        MinRate ->
            { currentForm
                | minRate = Result.withDefault 0 (String.toInt content)
            }

        MaxRate ->
            { currentForm
                | maxRate = Result.withDefault 0 (String.toInt content)
            }

        CV ->
            { currentForm | cv = content }

        LinkedIn ->
            { currentForm | linkedIn = content }

        Twitter ->
            { currentForm | twitter = content }

        GitHub ->
            { currentForm | gitHub = content }

        Website ->
            { currentForm | website = content }

        Q1 ->
            { currentForm | q1 = content }

        Q2 ->
            { currentForm | q2 = content }

        Q3 ->
            { currentForm | q3 = content }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateForm fieldType content ->
            let
                newForm =
                    createNewForm model.airtableForm fieldType content
            in
                ( { model | airtableForm = newForm }, Cmd.none )

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

        UrlChange location ->
            ( { model | route = getRoute location.hash }, Task.attempt (always NoOp) (toTop "container") )

        SendForm ->
            ( { model | formSent = Pending }, sendFormCmd model )

        OnFormSent (Ok result) ->
            case result.success of
                True ->
                    ( { model
                        | airtableForm = initForm
                        , formSent = Success
                        , route = ThankYou
                      }
                    , Cmd.none
                    )

                False ->
                    ( { model | formSent = FailureServer }, Cmd.none )

        OnFormSent (Err _) ->
            ( { model | formSent = FailureServer }, Cmd.none )

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
