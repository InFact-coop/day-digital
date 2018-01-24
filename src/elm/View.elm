module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Routes.AboutYou exposing (..)
import Routes.FourOhFour exposing (..)
import Routes.Home exposing (..)
import Routes.NextRole exposing (..)
import Routes.ThankYou exposing (..)
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

                FourOhFour ->
                    fourohfour model

                NextRole ->
                    nextRole model

                ThankYou ->
                    thankYou model
    in
    div [ class "w-100 fixed overflow-y-scroll top-0 bottom-0 bg-light-blue m0-auto cover", id "container" ]
        [ page
        ]
