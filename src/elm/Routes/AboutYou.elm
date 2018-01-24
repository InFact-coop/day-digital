module Routes.AboutYou exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


aboutYou : Model -> Html Msg
aboutYou model =
    section [ class "bg-light-blue m0-auto h-100" ]
        [ header []
            [ h1 [ class "tc dark-gray raleway fw2 pa5-ns pa4 f3 m0-auto" ] [ text "Tell us about you" ]
            ]
        , section [ class "w-50-l w-90 w-75-m center bg-white br3 shadow-1 pv3" ]
            [ article [ class " w-90 center pv1" ]
                [ div []
                    [ div [ class "mid-gray b bb b--light-gray" ] [ text "About you" ]
                    , div [ class "open-sans black fw4 flex justify-between flex-wrap f6" ]
                        [ div [ class "w-50-ns w-100 pv3 flex-column bg-none" ]
                            [ text "Full Name"
                            , div [] [ input [ type_ "text", class "br4 b--moon-gray w-75 h2 mt2 ba ba" ] [] ]
                            ]
                        , div [ class "w-50-ns w-100 pv3 flex-column bg-none" ]
                            [ text "Phone Number"
                            , div [] [ input [ type_ "text", class "br4 b--moon-gray w-75 h2 mt2 ba" ] [] ]
                            ]
                        , div [ class "w-50-ns w-100 pv3 flex-column bg-none" ]
                            [ text "Email"
                            , div [] [ input [ type_ "text", class "br4 b--moon-gray w-75 h2 mt2 ba" ] [] ]
                            ]
                        ]
                    ]
                ]
            , article [ class "mid-gray b bb b--light-gray w-90 center pv1" ] [ text "What kind of job are you looking for " ]
            , article [ class " w-90 center pv1" ]
                [ div []
                    [ div [ class "mid-gray b bb b--light-gray" ] [ text "Link to your CV" ]
                    , div [ class "open-sans black fw4 flex justify-between flex-wrap f6" ]
                        [ div [ class "w-50-ns w-100 pv3 flex-column bg-none" ]
                            [ text "Add a link to your CV here"
                            , div [] [ input [ type_ "text", class "br4 b--moon-gray w-75 h2 mt2 ba" ] [] ]
                            ]
                        ]
                    ]
                ]
            , article [ class " w-90 center pv1" ]
                [ div []
                    [ div [ class "mid-gray b bb b--light-gray" ] [ text "Add links to your social media accounts" ]
                    , div [ class "open-sans black fw4 flex justify-between flex-wrap f6" ]
                        [ div [ class "w-50-ns w-100 pv3 flex-column bg-none" ]
                            [ text "LinkedIn"
                            , div [] [ input [ type_ "text", class "br4 b--moon-gray w-75 h2 mt2 ba" ] [] ]
                            ]
                        , div [ class "w-50-ns w-100 pv3 flex-column bg-none" ]
                            [ text "Twitter"
                            , div [] [ input [ type_ "text", class "br4 b--moon-gray w-75 h2 mt2 ba" ] [] ]
                            ]
                        , div [ class "w-50-ns w-100 pv3 flex-column bg-none" ]
                            [ text "Github"
                            , div [] [ input [ type_ "text", class "br4 b--moon-gray w-75 h2 mt2 ba" ] [] ]
                            ]
                        , div [ class "w-50-ns w-100 pv3 flex-column bg-none" ]
                            [ text "Personal Website"
                            , div [] [ input [ type_ "text", class "br4 b--moon-gray w-75 h2 mt2 ba" ] [] ]
                            ]
                        ]
                    ]
                ]
            ]
        ]
