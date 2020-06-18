module Main exposing (main)

import Browser
import Element
import Element.Background
import Face
import Html exposing (Html)
import Task
import Time exposing (Posix)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { zone : Time.Zone
    , time : Posix
    }


type Msg
    = Tick Posix
    | AdjustTimeZone Time.Zone


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model Time.utc (Time.millisToPosix 0)
    , Task.perform AdjustTimeZone Time.here
    )


view : Model -> Html msg
view model =
    Element.layout [ Element.Background.color (Element.rgb255 0xBC 0xC1 0xC1) ]
        (Element.column []
            [ Element.html (Face.view model.time) ]
        )


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        Tick posix ->
            ( { model | time = posix }, Cmd.none )

        AdjustTimeZone timeZone ->
            ( { model | zone = timeZone }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Time.every 1000 Tick
