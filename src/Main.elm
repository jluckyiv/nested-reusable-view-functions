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
    = UpdateColorRed Int
    | UpdateColorGreen Int
    | UpdateColorBlue Int


update : Msg -> Model -> Model
update msg model =
    let
        { red, green, blue } =
            Color.toRgb model.color
    in
    case msg of
        UpdateColorRed newRedValue ->
            { model | color = Color.rgb newRedValue green blue }

        UpdateColorGreen newGreenValue ->
            { model | color = Color.rgb red newGreenValue blue }

        UpdateColorBlue newBlueValue ->
            { model | color = Color.rgb red green newBlueValue }



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


colorPicker : Color -> Html.Html Msg
colorPicker { red, green, blue } =
    Html.div []
        [ colorSlider "Red" red UpdateColorRed
        , colorSlider "Green" green UpdateColorGreen
        , colorSlider "Blue" blue UpdateColorBlue
        , Html.div
            [ Attr.style "height" "100px"
            , Attr.style "width" "100px"
            , Attr.style "background-color"
                (toColorCss red green blue)
            ]
            []
        ]


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ colorPicker model.color
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


toColorCss red green blue =
    "rgb("
        ++ String.fromInt red
        ++ ","
        ++ String.fromInt green
        ++ ","
        ++ String.fromInt blue
        ++ ")"
