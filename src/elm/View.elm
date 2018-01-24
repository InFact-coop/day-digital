module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Routes.AboutYou exposing (..)
import Routes.Home exposing (..)
import Routes.FourOhFour exposing (..)
import Routes.Video exposing (..)
import Types exposing (..)


view : Model -> Html Msg
view model =
    let
        page =
            case model.route of
                Home ->
                    home model

                AboutYou ->
                    aboutYou model

                Video ->
                    videoRoute model

                FourOhFour ->
                    fourohfour model
    in
        div [ class "w-100 fixed overflow-y-scroll top-0 bottom-0", id "container" ]
            [ page
            ]
