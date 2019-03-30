module Main exposing (main)

import Browser
import Color exposing (Color)
import Html
import Html.Attributes as Attr
import Html.Events as Evt



---- MODEL


type alias Model =
    { color : Color }


initialModel : Model
initialModel =
    { color = Color.rgb 50 200 100
    }



---- UDPATE


type Msg
    = UpdateColor Color


update : Msg -> Model -> Model
update msg model =
    let
        { red, green, blue } =
            Color.toRgb model.color
    in
    case msg of
        UpdateColor newColor ->
            { model | color = newColor }



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
            , Evt.onInput (toMsg << intFromString value)
            ]
            []
        , Html.span [] [ Html.text (String.fromInt value) ]
        ]


colorPicker : Color -> (Color -> msg) -> Html.Html msg
colorPicker ({ red, green, blue } as color) toMsg =
    Html.div []
        [ colorSlider "Red" red (toMsg << adjustRed color)
        , colorSlider "Green" green (toMsg << adjustGreen color)
        , colorSlider "Blue" blue (toMsg << adjustBlue color)
        , Html.div
            [ Attr.style "height" "100px"
            , Attr.style "width" "100px"
            , Attr.style "background-color" (rgbStringFromColor color)
            ]
            []
        ]


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ colorPicker model.color UpdateColor
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


intFromString : Int -> String -> Int
intFromString defaultValue strValue =
    strValue
        |> String.toInt
        |> Maybe.withDefault defaultValue


rgbStringFromColor : Color -> String
rgbStringFromColor { red, green, blue } =
    "rgb("
        ++ String.fromInt red
        ++ ","
        ++ String.fromInt green
        ++ ","
        ++ String.fromInt blue
        ++ ")"


adjustRed : Color -> Int -> Color
adjustRed { green, blue } red =
    Color.rgb red green blue


adjustGreen : Color -> Int -> Color
adjustGreen { red, blue } green =
    Color.rgb red green blue


adjustBlue : Color -> Int -> Color
adjustBlue { red, green } blue =
    Color.rgb red green blue
