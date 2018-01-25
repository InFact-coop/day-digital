port module State exposing (..)

import Dom.Scroll exposing (..)
import Task
import Time exposing (Time, second)
import Types exposing (..)


-- MODEL


initModel : Model
initModel =
    let
        initForm =
            Form "" "" "" "" "" "" "" "" 0 0 "" "" "" "" "" "" "" ""
    in
        { route = Home
        , videoStage = StagePreRecord
        , videoMessage = ""
        , messageLength = 0
        , paused = True
        , airtableForm = initForm
        }



--UPDATE


getRoute : String -> Route
getRoute hash =
    case hash of
        "#home" ->
            Home

        "#about-you" ->
            AboutYou

        "#next-role" ->
            NextRole

        "#thank-you" ->
            ThankYou

        "#personal-intro" ->
            PersonalIntro

        "#challenging-project" ->
            ChallengingProject

        _ ->
            FourOhFour


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
            if getRoute location.hash == NextRole then
                ( { model | route = getRoute location.hash }
                , Cmd.batch
                    [ Task.attempt (always NoOp) (toTop "container")
                    , videoRoute ()
                    ]
                )
            else
                ( { model | route = getRoute location.hash }
                , Task.attempt (always NoOp) (toTop "container")
                )

        NoOp ->
            ( model, Cmd.none )


port recordStart : String -> Cmd msg


port recordStop : String -> Cmd msg


port videoRoute : () -> Cmd msg


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
