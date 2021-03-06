module Main exposing (main)

import Browser
import Color exposing (Color)
import ColorPicker exposing (colorPicker)
import Html
import Html.Attributes as Attr



---- MODEL


type alias Model =
    { color1 : Color
    , color2 : Color
    }


initialModel : Model
initialModel =
    { color1 = Color.rgb 50 200 100
    , color2 = Color.rgb 50 200 100
    }



---- UDPATE


type Msg
    = UpdateColor1 Color
    | UpdateColor2 Color


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateColor1 newColor ->
            { model | color1 = newColor }

        UpdateColor2 newColor ->
            { model | color2 = newColor }



---- VIEW


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ Html.h1 [] [ Html.text "Nested Reusable View Functions in Elm" ]
        , Html.a
            [ Attr.href "https://medium.com/@mickey.vip/an-approach-to-nested-reusable-view-functions-in-elm-a1531b9abaf3" ]
            [ Html.text "from this medium article" ]
        , colorPicker "Color 1" model.color1 UpdateColor1
        , Html.hr [] []
        , colorPicker "Color 2" model.color2 UpdateColor2
        ]



---- MAIN


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
