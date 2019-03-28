module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Events exposing (onClick)



---- MODEL


type alias Model =
    Int


init : Model
init =
    0



---- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick (Decrease 1) ] [ text "Decrease" ]
        , text (String.fromInt model)
        , button [ onClick (Increase 1) ] [ text "Increase" ]
        ]



---- UPDATE


type Msg
    = Increase Int
    | Decrease Int


update msg model =
    case msg of
        Decrease int ->
            model - 1

        Increase int ->
            model + 1


main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
