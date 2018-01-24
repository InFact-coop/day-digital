module Components.Questions exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


questionTemplate : ( String, String ) -> Html Msg
questionTemplate ( title, back ) =
    section [ class "bg-light-blue m0-auto cover" ]
        [ header []
            [ h1 [ class "tc dark-gray raleway fw2 pa5-ns pa4 f2 m0-auto" ] [ text "In your own words" ]
            ]
        , a [ href ("#" ++ back), class "no-underline" ]
            [ div [ class "w-60-l w-90 w-75-m center mid-gray fw1 raleway mb2" ]
                [ img [ src "./assets/back.svg", class "h1 mr2" ] []
                , text "Go Back"
                ]
            ]
        , section [ class "w-60-l w-90 w-75-m center bg-white br3 shadow-1 pb5 pt3" ]
            [ article [ class " w-90 center pv1" ]
                [ h2 [ class "mid-gray raleway" ] [ text "One video is worth 1000 (written!) words..." ]
                , p [ class "mid-gray raleway fw1" ] [ text "In this section we would like you to make a short video or voice recording of yourself, telling us in your own words what you are looking for." ]
                , h3 [ class "center tc dark-gray pv4" ] [ text title ]
                , div [ class "flex flex-row flex-wrap center tc w-75 justify-between mr1" ]
                    [ div [ class "w-50-ns w-100 mid-gray flex flex-column mv2" ]
                        [ img [ src "./assets/rec_video.svg", class "h5 mb2" ] []
                        , text "Click to Record Video"
                        ]
                    , div [ class "w-50-ns w-100 mid-gray flex flex-column mv2" ]
                        [ img [ src "./assets/rec_audio.svg", class "h5 mb2" ] []
                        , text "Click to Record Audio"
                        ]
                    ]
                ]
            ]
        ]