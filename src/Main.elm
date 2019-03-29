module Main exposing (main)

import Browser
import Html
import Html.Attributes as Attr
import Html.Events as Evt



---- MODEL


type alias Model =
    { redValue : Int
    , greenValue : Int
    , blueValue : Int
    }


initialModel : Model
initialModel =
    { redValue = 50
    , greenValue = 50
    , blueValue = 50
    }



---- UDPATE


type Msg
    = UpdateColorRed Int
    | UpdateColorGreen Int
    | UpdateColorBlue Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateColorRed newRedValue ->
            { model | redValue = newRedValue }

        UpdateColorGreen newGreenValue ->
            { model | greenValue = newGreenValue }

        UpdateColorBlue newBlueValue ->
            { model | blueValue = newBlueValue }



---- VIEW


colorSlider : String -> Int -> (Int -> msg) -> Html.Html msg
colorSlider name value toMsg =
    Html.div []
        [ Html.p [] [ Html.text name ]
        , Html.input
            [ Attr.type_ "range"
            , Attr.name name
            , Attr.min "0"
            , Attr.max "255"
            , Attr.value (String.fromInt value)
            , Evt.onInput (toMsg << toInt value)
            ]
            []
        , Html.span [] [ Html.text (String.fromInt value) ]
        ]


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ colorSlider "Red" model.redValue UpdateColorRed
        , colorSlider "Green" model.greenValue UpdateColorGreen
        , colorSlider "Blue" model.blueValue UpdateColorBlue
        ]



---- MAIN


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }



---- HELPERS


toInt : Int -> String -> Int
toInt defaultValue strValue =
    strValue
        |> String.toInt
        |> Maybe.withDefault defaultValue
