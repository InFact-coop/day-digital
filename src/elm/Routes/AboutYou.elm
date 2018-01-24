module Routes.AboutYou exposing (..)

import Components.GrayButton exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


aboutYou : Model -> Html Msg
aboutYou model =
    section [ class "bg-light-blue m0-auto cover" ]
        [ header []
            [ h1 [ class "tc dark-gray raleway fw2 pa5-ns pa4 f2 m0-auto" ] [ text "Tell us about you" ]
            ]
        , section [ class "w-50-l w-90 w-75-m center bg-white br3 shadow-1 pv3" ]
            [ article [ class " w-90 center pv1" ]
                [ div []
                    [ img [ src "./assets/about_you.svg", class "absolute minus-margin h3" ] []
                    , div [ class "mid-gray b bb b--light-gray f3 f3 raleway" ] [ text "About you" ]
                    , div [ class "open-sans black fw4 flex justify-between flex-wrap f6" ]
                        [ div [ class "w-50-ns w-100 pv3 flex-column bg-none" ]
                            [ text "Full Name"
                            , div [] [ input [ type_ "text", class "br4 b--moon-gray w-75 h2 mt2 ba o-50 ba" ] [] ]
                            ]
                        , div [ class "w-50-ns w-100 pv3 flex-column bg-none" ]
                            [ text "Phone Number"
                            , div [] [ input [ type_ "text", class "br4 b--moon-gray w-75 h2 mt2 ba o-50" ] [] ]
                            ]
                        , div [ class "w-50-ns w-100 pv3 flex-column bg-none" ]
                            [ text "Email"
                            , div [] [ input [ type_ "text", class "br4 b--moon-gray w-75 h2 mt2 ba o-50" ] [] ]
                            ]
                        ]
                    ]
                ]
            , article [ class " w-90 center pv1" ]
                [ div []
                    [ img [ src "./assets/job_spec.svg", class "absolute minus-margin h3" ] []
                    , div [ class "mid-gray b bb b--light-gray f3 raleway" ] [ text "What kind of job are you looking for?" ]
                    , div [ class "black f5 pv2 open-sans" ] [ text "Type of job" ]
                    , div [ class "mid-gray fw1 raleway flex flex-row" ]
                        [ div [ class "pr3 f5 pb2 w5" ]
                            [ input [ type_ "checkbox", class "mr2" ] []
                            , text "Backend"
                            ]
                        , div [ class " f5 pb2" ]
                            [ input [ type_ "checkbox" ] []
                            , text "Product Manager"
                            ]
                        ]
                    , div [ class "mid-gray fw1 raleway flex flex-row" ]
                        [ div [ class "pr3 f5 pb2 w5" ]
                            [ input [ type_ "checkbox", class "mr2" ] []
                            , text "Frontend"
                            ]
                        , div [ class " f5 pb2" ]
                            [ input [ type_ "checkbox" ] []
                            , text "Visual Designer"
                            ]
                        ]
                    , div [ class "mid-gray fw1 raleway flex flex-row" ]
                        [ div [ class "pr3 f5 pb2 w5" ]
                            [ input [ type_ "checkbox", class "mr2" ] []
                            , text "Full Stack"
                            ]
                        , div [ class " f5 pb2" ]
                            [ input [ type_ "checkbox" ] []
                            , text "User Research"
                            ]
                        ]
                    , div [ class "mid-gray fw1 raleway flex flex-column" ]
                        [ div [ class "pr3 f5 pb2 " ]
                            [ input [ type_ "checkbox", class "mr2" ] []
                            , text "Other"
                            ]
                        , input [ type_ "text", class "w-20 h2 ba b--moon-gray o-50 br4 pl2", placeholder "If other, please state" ] []
                        ]
                    , div [ class "black f5 pv2 open-sans mt3" ] [ text "Start Date" ]
                    , input [ type_ "date", class "w-20 h2 ba b--moon-gray o-50 br4 pl2" ] []
                    , div [ class "black f5 pv2 open-sans mt3" ] [ text "Contract Length" ]
                    , div [ class "mid-gray fw1 raleway" ]
                        [ div [ class "pr3 f5 pb2" ]
                            [ input [ type_ "checkbox", class "mr2" ] []
                            , text "1 month"
                            ]
                        , div [ class "pr3 f5 pb2" ]
                            [ input [ type_ "checkbox", class "mr2" ] []
                            , text "3 months"
                            ]
                        , div [ class "pr3 f5 pb2" ]
                            [ input [ type_ "checkbox", class "mr2" ] []
                            , text "6 months"
                            ]
                        , div [ class "pr3 f5 pb2" ]
                            [ input [ type_ "checkbox", class "mr2" ] []
                            , text "1 year"
                            ]
                        , div [ class "pr3 f5 pb2" ]
                            [ input [ type_ "checkbox", class "mr2" ] []
                            , text "other"
                            ]
                        , div [ class "f6 flex flex-column" ]
                            [ text "How long is the contract length you are after"
                            , input [ type_ "text", class "w-20 br4 ba b--moon-gray h2 pl2 mid-gray mt2", placeholder "Please state" ] []
                            ]
                        ]
                    , div [ class "black f5 pv2 open-sans mt3 gray" ]
                        [ text "Rate" ]
                    , div
                        [ class "mid-gray mb3" ]
                        [ text "Min:"
                        , input [ type_ "text", class "w-1s0 br4 ba b--moon-gray h2 pl2 mid-gray mt2 mr3", placeholder "£" ] []
                        , text "Max:"
                        , input [ type_ "text", class "w-1s0 br4 ba b--moon-gray h2 pl2 mid-gray mt2", placeholder "£" ] []
                        ]
                    ]
                ]
            , article [ class " w-90 center pv1" ]
                [ div []
                    [ img [ src "./assets/cv.svg", class "absolute minus-margin h3" ] []
                    , div [ class "mid-gray b bb b--light-gray f3 raleway" ] [ text "Link to your CV" ]
                    , div [ class "open-sans black fw4 flex justify-between flex-wrap f6" ]
                        [ div [ class "w-50-ns w-100 pv3 flex-column bg-none" ]
                            [ text "Add a link to your CV here"
                            , div [] [ input [ type_ "text", class "br4 b--moon-gray w-75 h2 mt2 ba o-50" ] [] ]
                            ]
                        ]
                    ]
                ]
            , article [ class " w-90 center pv1" ]
                [ div []
                    [ img [ src "./assets/social_media.svg", class "absolute minus-margin h3" ] []
                    , div [ class "mid-gray b bb b--light-gray f3 raleway" ] [ text "Add links to your social media accounts" ]
                    , div [ class "open-sans black fw4 flex justify-between flex-wrap f6" ]
                        [ div [ class "w-50-ns w-100 pv3 flex-column bg-none" ]
                            [ text "LinkedIn"
                            , div [] [ input [ type_ "text", class "br4 b--moon-gray w-75 h2 mt2 ba o-50 o-50" ] [] ]
                            ]
                        , div [ class "w-50-ns w-100 pv3 flex-column bg-none" ]
                            [ text "Twitter"
                            , div [] [ input [ type_ "text", class "br4 b--moon-gray w-75 h2 mt2 ba o-50" ] [] ]
                            ]
                        , div [ class "w-50-ns w-100 pv3 flex-column bg-none" ]
                            [ text "Github"
                            , div [] [ input [ type_ "text", class "br4 b--moon-gray w-75 h2 mt2 ba o-50" ] [] ]
                            ]
                        , div [ class "w-50-ns w-100 pv3 flex-column bg-none" ]
                            [ text "Personal Website"
                            , div [] [ input [ type_ "text", class "br4 b--moon-gray w-75 h2 mt2 ba o-50" ] [] ]
                            ]
                        ]
                    ]
                ]
            ]
        , grayButton ( "Next", "nextRole" )
        ]
