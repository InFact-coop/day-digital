module State exposing (..)

import Dom.Scroll exposing (..)
import Types exposing (..)
import Task


-- MODEL


initModel : Model
initModel =
    { route = Hello }



--UPDATE


getRoute : String -> Route
getRoute hash =
    case hash of
        "#hello" ->
            Hello

        _ ->
            Hello


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange location ->
            ( { model | route = getRoute location.hash }, Task.attempt (always NoOp) (toTop "container") )

        NoOp ->
            ( model, Cmd.none )
