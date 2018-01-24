module State exposing (..)

import Dom.Scroll exposing (..)
import Task
import Types exposing (..)


-- MODEL


initModel : Model
initModel =
    { route = AboutYouRoute }



--UPDATE


getRoute : String -> Route
getRoute hash =
    case hash of
        "#hello" ->
            HelloRoute

        "#aboutYou" ->
            AboutYouRoute

        _ ->
            HelloRoute


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange location ->
            ( { model | route = getRoute location.hash }, Task.attempt (always NoOp) (toTop "container") )

        NoOp ->
            ( model, Cmd.none )
