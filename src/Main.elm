module Main exposing (main)

import Browser
import Html
import Html.Attributes as Attr
import Html.Events as Evt



---- MODEL


type alias Model =
    { redValue : String }


initialModel : Model
initialModel =
    { redValue = "50" }


type Msg
    = UpdateColorRed String


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateColorRed newRedValue ->
            { model | redValue = newRedValue }


colorRedSlider : String -> Html.Html Msg
colorRedSlider redValue =
    Html.input
        [ Attr.type_ "range"
        , Attr.name "color-red"
        , Attr.min "0"
        , Attr.max "255"
        , Attr.value redValue
        , Evt.onInput UpdateColorRed
        ]
        []


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ colorRedSlider model.redValue
        , Html.span [] [ Html.text model.redValue ]
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
