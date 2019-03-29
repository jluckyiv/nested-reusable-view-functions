module Main exposing (main)

import Browser
import Html
import Html.Attributes as Attr
import Html.Events as Evt



---- MODEL


type alias Model =
    { redValue : Int }


initialModel : Model
initialModel =
    { redValue = 50 }



---- UDPATE


type Msg
    = UpdateColorRed Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateColorRed newRedValue ->
            { model | redValue = newRedValue }



---- VIEW


colorSlider : String -> Int -> (Int -> msg) -> Html.Html msg
colorSlider name value toMsg =
    Html.div []
        [ Html.input
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
